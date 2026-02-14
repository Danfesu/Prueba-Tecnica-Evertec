import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? trailingText;
  final VoidCallback onPressed;
  const CustomListTile({
    super.key,
    required this.color,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailingText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.surfaceBright,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onPressed,
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 15),
        ),
        title: Text(title),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: textTheme.labelSmall?.copyWith(
                  color: colors.onSurface.withValues(alpha: 0.6),
                  letterSpacing: 1.0,
                ),
              )
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (trailingText != null)
              Text(
                trailingText!,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            Icon(Icons.chevron_right_outlined),
          ],
        ),
      ),
    );
  }
}
