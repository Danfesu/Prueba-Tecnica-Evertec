import 'package:evertec_technical_test/core/network/network_info.dart';
import 'package:evertec_technical_test/features/home/data/datasources/products_local_datasorce.dart';
import 'package:evertec_technical_test/features/home/domain/usecases/get_product_by_id.dart';
import 'package:evertec_technical_test/features/home/presentation/cubits/detail/detail_product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailProductCubit extends Cubit<DetailProductState> {
  final GetProductById getProductById;
  final NetworkInfo networkInfo;
  final ProductLocalDataSource localDataSource;

  DetailProductCubit(
    this.getProductById,
    this.networkInfo,
    this.localDataSource,
  ) : super(DetailProductState.initial());

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
        // ESCENARIO 2: Datos cargados desde Drift
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
