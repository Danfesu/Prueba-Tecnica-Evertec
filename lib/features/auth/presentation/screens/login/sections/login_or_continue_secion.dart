import 'package:evertec_technical_test/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:evertec_technical_test/features/auth/presentation/widgets/buttons/other_login_button.dart';
import 'package:evertec_technical_test/features/shared/widgets/divider/divider_with_message.dart';
import 'package:evertec_technical_test/features/shared/widgets/no_implemented.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Sección alternativa del login que permite continuar
/// con proveedores externos (ej: Google) o navegar
/// hacia el registro de usuario.
///
/// Esta clase pertenece a la capa de presentación y
/// delega la lógica de autenticación al [AuthCubit].
class LoginOrContinueSecion extends StatelessWidget {
  const LoginOrContinueSecion({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        /// Divisor visual con mensaje que separa
        /// el login tradicional del login social.
        DividerWithMessage(message: "O CONTINUAR CON"),

        SizedBox(height: 8.0),

        /// Botón para autenticación con Google.
        ///
        /// Al presionarlo, ejecuta el método
        /// `loginWithGoogle` del [AuthCubit].
        SizedBox(
          width: double.infinity,
          child: OtherLoginButton(
            icon: Icons.language_outlined,
            text: "Google",
            onPressed: () async {
              context.read<AuthCubit>().loginWithGoogle(context);
            },
          ),
        ),

        SizedBox(height: 15.0),

        /// Sección inferior para redirigir al registro.
        /// Actualmente muestra un diálogo indicando
        /// que la funcionalidad no está implementada.
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8.0,
          children: [
            Text(
              'No tienes cuenta?',
              style: TextStyle(color: colors.onSurface.withValues(alpha: 0.5)),
            ),
            GestureDetector(
              onTap: () {
                NoImplemented.showNotImplementedDialog(context);
              },
              child: Text(
                'Registrate',
                style: TextStyle(color: colors.primary),
              ),
            ),
          ],
        ),

        SizedBox(height: 10.0),
      ],
    );
  }
}
