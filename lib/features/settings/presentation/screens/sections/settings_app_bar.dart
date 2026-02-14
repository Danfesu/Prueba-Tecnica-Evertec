import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SettingsAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<SettingsAppBar> createState() => _SettingsAppBarState();
}

class _SettingsAppBarState extends State<SettingsAppBar> {
  final key = GlobalKey<TooltipState>();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
      title: Text("Configuración"),
      actions: [
        Tooltip(
          key: key,
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.45,
          ),
          padding: EdgeInsets.all(15.0),
          message: "Aqui podra configurar las preferencias de su aplicación.",
          textStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceBright,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            onPressed: () {
              key.currentState?.ensureTooltipVisible();
            },
            icon: Icon(Icons.help_rounded),
          ),
        ),
      ],
    );
  }
}
