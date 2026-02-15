import 'dart:async';

import 'package:evertec_technical_test/core/services/network/network_info.dart';
import 'package:evertec_technical_test/features/home/data/datasources/products_local_datasorce.dart';
import 'package:evertec_technical_test/features/home/domain/usecases/get_all_products.dart';
import 'package:evertec_technical_test/features/home/domain/usecases/sync_products.dart';
import 'package:evertec_technical_test/features/home/presentation/cubits/products/products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit encargado de manejar el estado de la lista de productos.
///
/// Pertenece a la capa de presentación (Presentation Layer)
/// y coordina:
/// - Obtención de productos (GetAllProducts)
/// - Sincronización con la API (SyncProducts)
/// - Verificación de conectividad (NetworkInfo)
/// - Validación de datos en caché (ProductLocalDataSource)
///
/// Implementa una estrategia offline-first con 3 escenarios:
///
/// Sin conexión y sin datos en caché → Error.
/// Sin conexión pero con datos en caché → Mostrar datos offline.
/// Con conexión → Obtener datos frescos y sincronizar automáticamente.
class ProductsCubit extends Cubit<ProductsState> {
  /// Caso de uso para obtener todos los productos.
  final GetAllProducts getAllProducts;

  /// Caso de uso para sincronizar productos con la API.
  final SyncProducts syncProducts;

  /// Servicio para verificar conectividad a internet.
  final NetworkInfo networkInfo;

  /// DataSource local para validar existencia de datos en caché.
  final ProductLocalDataSource localDataSource;

  /// Suscripción al stream de cambios de conectividad.
  StreamSubscription? _connectivitySubscription;

  ProductsCubit(
    this.getAllProducts,
    this.syncProducts,
    this.networkInfo,
    this.localDataSource,
  ) : super(const ProductsState.initial()) {
    _initConnectivityListener();
    loadProducts();
  }

  /// Inicializa el listener que detecta cambios en la conectividad.
  ///
  /// Permite reaccionar automáticamente cuando el dispositivo
  /// recupera o pierde conexión.
  void _initConnectivityListener() {
    _connectivitySubscription = networkInfo.onConnectivityChanged.listen((
      isConnected,
    ) {
      _handleConnectivityChange(isConnected);
    });
  }

  /// Maneja los cambios de conectividad.
  ///
  /// - Si el dispositivo se reconecta y estaba en modo offline,
  ///   ejecuta sincronización automática.
  /// - Actualiza el flag `isOffline` en el estado actual.
  Future<void> _handleConnectivityChange(bool isConnected) async {
    final currentState = state.mapOrNull(loaded: (value) => value);

    // ESCENARIO 3: Reconexión - sincronizar automáticamente
    if (isConnected && currentState != null && currentState.isOffline) {
      await synchronizeProducts();
    }

    // Actualizar estado de conectividad
    if (currentState != null) {
      emit(currentState.copyWith(isOffline: !isConnected));
    }
  }

  /// Carga la lista de productos.
  ///
  /// Parámetros:
  /// - [showLoading]: indica si se debe emitir estado de loading.
  ///
  /// Flujo:
  /// 1. Verifica conectividad.
  /// 2. Ejecuta el caso de uso.
  /// 3. Emite:
  ///    - Error si falla.
  ///    - Loaded si obtiene datos.
  ///
  /// Además informa:
  /// - `isOffline`: si el dispositivo no tiene conexión.
  /// - `isFromCache`: si los datos provienen del almacenamiento local.
  Future<void> loadProducts({bool showLoading = true}) async {
    if (showLoading) {
      emit(ProductsState.loading());
    }

    final isConnected = await networkInfo.isConnected;
    final result = await getAllProducts();

    result.fold(
      (failure) {
        // ESCENARIO 1: Error sin datos
        emit(
          ProductsState.error(
            message: failure.message,
            isOffline: !isConnected,
          ),
        );
      },
      (products) async {
        // ESCENARIO 2: Datos cargados desde Drift o API
        final hasCached = await localDataSource.hasCachedData();

        emit(
          ProductsState.loaded(
            products: products,
            isOffline: !isConnected,
            isFromCache: hasCached && !isConnected,
          ),
        );
      },
    );
  }

  /// Sincroniza productos con la API cuando hay conexión.
  ///
  /// Flujo:
  /// - Si hay productos cargados, emite estado `syncing`.
  /// - Ejecuta el caso de uso SyncProducts.
  /// - Si falla, vuelve al estado anterior.
  /// - Si tiene éxito, recarga productos desde la base local.
  Future<void> synchronizeProducts() async {
    final currentState = state.mapOrNull(loaded: (value) => value);

    if (currentState != null) {
      emit(ProductsState.syncing(currentProducts: currentState.products));

      final result = await syncProducts();

      result.fold(
        (failure) {
          // Volver al estado anterior si falla
          emit(currentState);
        },
        (_) {
          // Recargar datos después de sincronizar con Drift
          loadProducts(showLoading: false);
        },
      );
    } else {
      await loadProducts();
    }
  }

  /// Permite reintentar la carga de productos
  /// después de un error.
  Future<void> retry() async {
    await loadProducts();
  }

  /// Cancela la suscripción al stream de conectividad
  /// al cerrar el Cubit para evitar memory leaks.
  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
