import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const DrawerItem(
      {super.key,
      required this.icon,
      required this.label,
      required this.selected,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: selected
          ? BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
                  Colors.transparent,
                ],
                stops: [0.0, 0.9, 1.0],
              ),
              border: Border(
                  left: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 5,
              )))
          : null,
      child: ListTile(
        leading: Icon(
          icon,
          color: selected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface,
        ),
        title: Text(
          label,
          style: TextStyle(
              fontWeight: selected ? FontWeight.bold : FontWeight.normal),
        ),
        onTap: onTap,
      ),
    );
  }
}
