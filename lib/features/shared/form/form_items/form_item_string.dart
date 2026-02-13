import 'package:evertec_technical_test/features/shared/form/form_items/form_item.dart';
import 'package:flutter/material.dart';

// Clase para el elemento de texto (string) en el formulario
class FormItemString extends FormItem<String> {
  final bool obscureText;
  final String? hintText;
  final IconData? prefixIcon;

  FormItemString({
    required super.name,
    this.obscureText = false,
    this.hintText,
    super.onChanged,
    super.validator,
    super.label,
    super.topText,
    this.prefixIcon,
    super.spacing,
    super.defaultValue,
    super.child,
  });
}
