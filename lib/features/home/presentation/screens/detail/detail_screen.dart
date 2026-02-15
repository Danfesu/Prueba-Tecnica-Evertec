import 'package:evertec_technical_test/features/home/presentation/cubits/detail/detail_product_cubit.dart';
import 'package:evertec_technical_test/features/home/presentation/cubits/detail/detail_product_state.dart';
import 'package:evertec_technical_test/features/home/presentation/screens/detail/sections/detail_app_bar.dart';
import 'package:evertec_technical_test/features/home/presentation/screens/detail/sections/detail_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pantalla encargada de mostrar el detalle de un producto.
///
/// Pertenece a la capa de presentación (Presentation Layer)
/// y reacciona a los cambios de estado del [DetailProductCubit].
///
/// Maneja los siguientes estados:
/// - initial: No renderiza contenido.
/// - loading: Muestra indicador de carga.
/// - loaded: Muestra la información del producto.
/// - error: Muestra mensaje de error.
///
/// Utiliza `CustomScrollView` con slivers para permitir
/// una experiencia de scroll flexible (AppBar expandible, etc.).
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailProductCubit, DetailProductState>(
        builder: (context, state) {
          return state.when(
            /// Estado inicial: no muestra contenido.
            initial: () => SizedBox.shrink(),

            /// Estado de carga: muestra indicador circular.
            loading: () => Center(child: CircularProgressIndicator()),

            /// Estado cargado: muestra información del producto.
            loaded: (product, isOffline, isFromCache) {
              return CustomScrollView(
                physics: ClampingScrollPhysics(),
                slivers: [
                  /// AppBar personalizada con información principal.
                  DetailAppBar(product: product),

                  /// Sección con información detallada del producto.
                  DetailInfo(product: product),
                ],
              );
            },

            /// Estado de error: muestra mensaje correspondiente.
            error: (message, isOffline) => Center(child: Text(message)),
          );
        },
      ),
    );
  }
}
