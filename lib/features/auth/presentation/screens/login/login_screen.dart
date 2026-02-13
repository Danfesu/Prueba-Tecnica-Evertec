import 'package:evertec_technical_test/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:evertec_technical_test/features/auth/presentation/cubits/auth_state.dart';
import 'package:evertec_technical_test/features/auth/presentation/screens/login/sections/login_form_section.dart';
import 'package:evertec_technical_test/features/auth/presentation/screens/login/sections/login_or_continue_secion.dart';
import 'package:evertec_technical_test/features/auth/presentation/screens/login/sections/login_top_section.dart';
import 'package:evertec_technical_test/features/shared/extesions/snackbar_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (message) => context.showError(message),
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            initial: () => SizedBox.shrink(),
            loading: () => Center(child: CircularProgressIndicator()),
            authenticated: (user) => SizedBox.shrink(),
            orElse: () => SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: _buildContentLogin(context),
            ),
          );
        },
      ),
    );
  }

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
