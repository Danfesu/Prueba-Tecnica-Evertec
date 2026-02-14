import 'dart:async';

import 'package:evertec_technical_test/core/services/network/network_info.dart';
import 'package:evertec_technical_test/features/home/data/datasources/products_local_datasorce.dart';
import 'package:evertec_technical_test/features/home/domain/usecases/get_all_products.dart';
import 'package:evertec_technical_test/features/home/domain/usecases/sync_products.dart';
import 'package:evertec_technical_test/features/home/presentation/cubits/products/products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final GetAllProducts getAllProducts;
  final SyncProducts syncProducts;
  final NetworkInfo networkInfo;
  final ProductLocalDataSource localDataSource;

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

  void _initConnectivityListener() {
    _connectivitySubscription = networkInfo.onConnectivityChanged.listen((
      isConnected,
    ) {
      _handleConnectivityChange(isConnected);
    });
  }

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
        // ESCENARIO 2: Datos cargados desde Drift
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

  Future<void> retry() async {
    await loadProducts();
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
