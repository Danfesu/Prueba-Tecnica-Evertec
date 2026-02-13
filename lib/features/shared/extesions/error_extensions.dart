import 'package:evertec_technical_test/features/shared/widgets/buttons/general_button.dart';
import 'package:flutter/material.dart';

extension ErrorExtensions on BuildContext {
  Future<void> showErrorDialog(
    String message,
    String subtitle,
    VoidCallback onRetry,
  ) {
    return showModalBottomSheet(
      context: this,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        final textTheme = Theme.of(context).textTheme;

        return SafeArea(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(message, style: textTheme.headlineMedium),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  Text(subtitle, style: textTheme.bodyLarge),

                  const SizedBox(height: 12),

                  Image.asset("assets/images/error.jpg"),

                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: GeneralButton(
                      text: "Reintentar",
                      onPressed: () {
                        Navigator.pop(context);
                        onRetry();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
