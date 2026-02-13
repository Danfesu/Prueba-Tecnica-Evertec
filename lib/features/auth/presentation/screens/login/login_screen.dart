import 'package:evertec_technical_test/features/auth/presentation/screens/login/sections/login_form_section.dart';
import 'package:evertec_technical_test/features/auth/presentation/screens/login/sections/login_or_continue_secion.dart';
import 'package:evertec_technical_test/features/auth/presentation/screens/login/sections/login_top_section.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: _buildContentLogin(context),
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
