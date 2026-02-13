import 'package:evertec_technical_test/features/main_layout/domain/usecases/get_screens.dart';
import 'package:evertec_technical_test/features/main_layout/presentation/cubits/layout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutCubit extends Cubit<LayoutState> {
  final GetScreens getScreens;
  LayoutCubit(this.getScreens) : super(LayoutState.initial());

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
