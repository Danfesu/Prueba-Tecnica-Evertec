import 'package:evertec_technical_test/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:evertec_technical_test/features/auth/presentation/widgets/buttons/other_login_button.dart';
import 'package:evertec_technical_test/features/shared/widgets/divider/divider_with_message.dart';
import 'package:evertec_technical_test/features/shared/widgets/no_implemented.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginOrContinueSecion extends StatelessWidget {
  const LoginOrContinueSecion({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        DividerWithMessage(message: "O CONTINUAR CON"),
        SizedBox(height: 8.0),
        SizedBox(
          width: double.infinity,
          child: OtherLoginButton(
            icon: Icons.language_outlined,
            text: "Google",
            onPressed: () async {
              context.read<AuthCubit>().singInGoogle();
            },
          ),
        ),
        SizedBox(height: 15.0),
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
