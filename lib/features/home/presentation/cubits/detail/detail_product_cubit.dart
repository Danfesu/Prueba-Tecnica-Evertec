import 'package:evertec_technical_test/core/services/network/network_info.dart';
import 'package:evertec_technical_test/features/home/data/datasources/products_local_datasorce.dart';
import 'package:evertec_technical_test/features/home/domain/usecases/get_product_by_id.dart';
import 'package:evertec_technical_test/features/home/presentation/cubits/detail/detail_product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit encargado de manejar el estado del detalle de un producto.
///
/// Pertenece a la capa de presentación (Presentation Layer)
/// y coordina:
/// - La ejecución del caso de uso [GetProductById]
/// - La verificación de conectividad mediante [NetworkInfo]
/// - La validación de datos en caché usando [ProductLocalDataSource]
///
/// Maneja distintos escenarios:
/// 1. Sin conexión y sin datos → Error.
/// 2. Sin conexión pero con datos en caché → Mostrar datos offline.
/// 3. Con conexión → Mostrar datos frescos.
class DetailProductCubit extends Cubit<DetailProductState> {
  /// Caso de uso para obtener un producto por su ID.
  final GetProductById getProductById;

  /// Servicio que permite verificar si existe conexión a internet.
  final NetworkInfo networkInfo;

  /// DataSource local para validar existencia de datos en caché.
  final ProductLocalDataSource localDataSource;

  DetailProductCubit(
    this.getProductById,
    this.networkInfo,
    this.localDataSource,
  ) : super(DetailProductState.initial());

  /// Carga el detalle del producto a partir de su [productId].
  ///
  /// Flujo:
  /// 1. Emite estado de loading.
  /// 2. Verifica conectividad.
  /// 3. Ejecuta el caso de uso.
  /// 4. Emite:
  ///    - Error si ocurre un fallo.
  ///    - Loaded si obtiene el producto.
  ///
  /// Además indica:
  /// - `isOffline`: si el dispositivo no tiene conexión.
  /// - `isFromCache`: si los datos provienen del almacenamiento local.
  Future<void> load(String productId) async {
    emit(DetailProductState.loading());

    final isConnected = await networkInfo.isConnected;
    final result = await getProductById(int.parse(productId));

    result.fold(
      (failure) {
        // ESCENARIO 1: Error sin datos
        emit(
          DetailProductState.error(
            message: failure.message,
            isOffline: !isConnected,
          ),
        );
      },
      (product) async {
        // ESCENARIO 2: Datos cargados desde Drift o fuente remota
        final hasCached = await localDataSource.hasCachedData();

        emit(
          DetailProductState.loaded(
            product: product!,
            isOffline: !isConnected,
            isFromCache: hasCached && !isConnected,
          ),
        );
      },
    );
  }
}
