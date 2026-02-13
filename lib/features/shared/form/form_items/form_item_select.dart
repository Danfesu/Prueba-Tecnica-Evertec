import 'package:evertec_technical_test/features/shared/form/form_items/form_item.dart';
import 'package:flutter/material.dart';

// Clase para el elemento de selección (dropdown) en el formulario
class FormItemSelect extends FormItem<String> {
  final List<String> options;
  final String? hintText;
  final IconData? prefixIcon;

  FormItemSelect({
    required super.name,
    required this.options,
    super.defaultValue,
    super.onChanged,
    super.validator,
    super.label,
    super.topText,
    this.hintText,
    this.prefixIcon,
    super.spacing,
    super.child,
  });
}
