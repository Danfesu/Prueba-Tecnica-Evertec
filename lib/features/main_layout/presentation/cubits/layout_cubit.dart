import 'package:evertec_technical_test/features/main_layout/domain/usecases/get_screens.dart';
import 'package:evertec_technical_test/features/main_layout/presentation/cubits/layout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit encargado de gestionar el estado del layout principal.
///
/// Se encarga de:
/// - Solicitar las pantallas disponibles mediante el caso de uso.
/// - Emitir los diferentes estados (loading, loaded, error).
/// - Controlar el flujo de carga de los módulos.
class LayoutCubit extends Cubit<LayoutState> {
  /// Caso de uso que obtiene las pantallas del layout.
  final GetScreens getScreens;

  /// Constructor que inicializa el estado en su valor inicial.
  LayoutCubit(this.getScreens) : super(LayoutState.initial());

  /// Método que carga las pantallas disponibles.
  ///
  /// Flujo:
  /// 1. Emite estado de loading.
  /// 2. Ejecuta el caso de uso.
  /// 3. Si es exitoso, emite estado loaded.
  /// 4. Si ocurre un error, emite estado error.
  void load() async {
    emit(LayoutState.loading());
    try {
      final screens = await getScreens();
      emit(LayoutState.loaded(pages: screens));
    } catch (e) {
      emit(LayoutState.error(message: "Error al cargar los modulos"));
    }
  }
}
