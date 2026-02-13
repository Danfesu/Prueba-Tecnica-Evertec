import 'package:evertec_technical_test/features/main_layout/domain/entities/item_page.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'layout_state.freezed.dart';

@freezed
class LayoutState with _$LayoutState {
  /// Estado inicial
  const factory LayoutState.initial() = _Initial;

  /// Estado de carga
  const factory LayoutState.loading() = _Loading;

  /// Estado cargado con éxito
  const factory LayoutState.loaded({required List<ItemPage> pages}) = _Loaded;

  /// Estado de error
  const factory LayoutState.error({required String message}) = _Error;
}
