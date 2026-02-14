import 'package:evertec_technical_test/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:evertec_technical_test/features/settings/presentation/screens/sections/settings_app_bar.dart';
import 'package:evertec_technical_test/features/settings/presentation/screens/sections/settings_avatar.dart';
import 'package:evertec_technical_test/features/settings/presentation/screens/sections/settings_options.dart';
import 'package:evertec_technical_test/features/settings/presentation/screens/sections/settings_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          SettingsAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(width: double.infinity),
                  SettingsAvatar(),
                  SettingsTheme(),
                  SizedBox(height: 10),
                  SettingsOptions(),
                  SizedBox(height: 20),
                  _buildLogoutButton(context),
                  SizedBox(height: 15),
                  Text(
                    "VERSION V1.0.0",
                    style: textTheme.labelLarge?.copyWith(
                      color: colors.onSurface.withValues(alpha: 0.3),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return FilledButton.icon(
      onPressed: () {
        context.read<AuthCubit>().logout();
      },
      label: Text("Cerrar sesión"),
      icon: Icon(Icons.logout),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(15),
        backgroundColor: Colors.redAccent.withValues(alpha: 0.15),
        foregroundColor: Colors.redAccent,
        minimumSize: Size(double.infinity, 40),
        iconSize: 20,
      ),
    );
  }
}
