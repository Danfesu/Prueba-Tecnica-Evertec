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
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
      child: Column(children: [LoginTopSection()]),
    );
  }
}
