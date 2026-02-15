import 'package:evertec_technical_test/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:evertec_technical_test/features/auth/presentation/cubits/auth_state.dart';
import 'package:evertec_technical_test/features/auth/presentation/screens/login/sections/login_form_section.dart';
import 'package:evertec_technical_test/features/auth/presentation/screens/login/sections/login_or_continue_secion.dart';
import 'package:evertec_technical_test/features/auth/presentation/screens/login/sections/login_top_section.dart';
import 'package:evertec_technical_test/features/shared/extesions/snackbar_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pantalla principal de inicio de sesión.
///
/// Esta vista pertenece a la capa de presentación y se encarga de:
/// - Escuchar los cambios de estado del [AuthCubit].
/// - Mostrar mensajes de error mediante Snackbar.
/// - Renderizar el formulario de login.
/// - Mostrar indicador de carga cuando el estado es `loading`.
///
/// Utiliza [BlocConsumer] para separar la lógica de escucha
/// (side effects) y construcción de la UI.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        /// Listener que reacciona a cambios de estado
        /// para ejecutar efectos secundarios (por ejemplo,
        /// mostrar mensajes de error).
        listener: (context, state) {
          state.maybeWhen(
            error: (message) => context.showError(message),
            orElse: () {},
          );
        },

        /// Builder que reconstruye la interfaz según el estado actual.
        builder: (context, state) {
          return state.maybeWhen(
            /// Estado de carga: muestra indicador de progreso.
            loading: () => Center(child: CircularProgressIndicator()),

            /// Estado autenticado: actualmente no renderiza nada.
            /// (Podría navegar a otra pantalla).
            authenticated: (user) => SizedBox.shrink(),

            /// Estado por defecto (no autenticado):
            /// muestra el contenido del formulario.
            orElse: () => SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: _buildContentLogin(context),
            ),
          );
        },
      ),
    );
  }

  /// Construye el contenido principal del login.
  ///
  /// Incluye:
  /// - Sección superior (logo o encabezado).
  /// - Formulario de credenciales.
  /// - Sección alternativa para continuar (ej: Google).
  ///
  /// Ajusta el padding dinámicamente según el tamaño
  /// de la pantalla para mantener un diseño responsivo.
  Widget _buildContentLogin(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.08,
      ),
      child: Column(
        children: [
          LoginTopSection(),
          LoginFormSection(),
          LoginOrContinueSecion(),
        ],
      ),
    );
  }
}
