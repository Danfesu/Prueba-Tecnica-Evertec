import 'package:evertec_technical_test/features/home/presentation/cubits/products/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Sección que se muestra cuando ocurre un error al cargar los productos.
///
/// Puede representar:
/// - Error por falta de conexión.
/// - Error general del servidor.
/// - Caso donde no existen datos almacenados localmente.
///
/// Permite al usuario reintentar la carga.
class ErrorSection extends StatelessWidget {
  /// Indica si el error fue causado por falta de conexión.
  final bool isOffline;

  /// Mensaje de error a mostrar.
  final String message;

  const ErrorSection({
    super.key,
    required this.isOffline,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Ícono dinámico dependiendo del tipo de error:
            /// - Sin conexión → nube tachada
            /// - Error general → ícono de error
            Icon(
              isOffline ? Icons.cloud_off_rounded : Icons.error_outline_rounded,
              size: 100,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 24),

            /// Título principal según el tipo de error
            Text(
              isOffline ? 'Sin Conexión' : 'Error',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 12),

            /// Mensaje detallado del error
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 8),

            /// Mensaje adicional indicando que no hay datos almacenados
            Text(
              'No hay datos almacenados',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade500,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 32),

            /// Botón para reintentar la carga de productos.
            /// Llama al método `retry()` del ProductsCubit.
            ElevatedButton.icon(
              onPressed: () {
                context.read<ProductsCubit>().retry();
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Reintentar'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
