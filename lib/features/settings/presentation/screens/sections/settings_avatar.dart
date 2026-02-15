import 'package:evertec_technical_test/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:evertec_technical_test/features/auth/presentation/cubits/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Widget que muestra el avatar del usuario en la pantalla de configuración.
///
/// Este widget utiliza [BlocBuilder] para escuchar el estado de [AuthCubit] y
/// mostrar la información del usuario autenticado. Incluye:
/// - Un [CircleAvatar] con un ícono de persona.
/// - Nombre del usuario.
/// - Correo electrónico del usuario.
class SettingsAvatar extends StatelessWidget {
  const SettingsAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        // Extrae la información del usuario autenticado, si existe
        final userAuthenticated = state.mapOrNull(authenticated: (s) => s);

        return Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 10),
              Text(
                userAuthenticated?.user.name ?? '',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                userAuthenticated?.user.email ?? '',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        );
      },
    );
  }
}
