import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_product_state.freezed.dart';

@freezed
class DetailProductState with _$DetailProductState {
  /// Estado inicial
  const factory DetailProductState.initial() = _Initial;

  /// Estado de carga
  const factory DetailProductState.loading() = _Loading;

  /// Estado autenticado
  const factory DetailProductState.loaded({
    required Product product,
    required bool isOffline,
    required bool isFromCache,
  }) = _Loaded;

  /// Estado de error
  const factory DetailProductState.error({
    required String message,
    required bool isOffline,
  }) = _Error;
}
