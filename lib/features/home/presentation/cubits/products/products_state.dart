import 'package:evertec_technical_test/features/home/domain/entities/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_state.freezed.dart';

@freezed
class ProductsState with _$ProductsState {
  /// Estado inicial
  const factory ProductsState.initial() = _Initial;

  /// Estado de carga
  const factory ProductsState.loading() = _Loading;

  /// Estado autenticado
  const factory ProductsState.loaded({
    required List<Product> products,
    required bool isOffline,
    required bool isFromCache,
  }) = _Loaded;

  const factory ProductsState.syncing({
    required List<Product> currentProducts,
  }) = _Syncing;

  /// Estado de error
  const factory ProductsState.error({
    required String message,
    required bool isOffline,
  }) = _Error;
}
