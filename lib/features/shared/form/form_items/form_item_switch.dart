import 'package:evertec_technical_test/features/shared/form/form_items/form_item.dart';
import 'package:flutter/material.dart';

// Clase para el elemento de switch en el formulario
class FormItemSwitch extends FormItem<bool> {
  final String? subTitle;
  final Color activeColor;
  final ListTileControlAffinity controlAffinity;

  FormItemSwitch({
    required super.name,
    required this.activeColor,
    this.controlAffinity = ListTileControlAffinity.leading,
    this.subTitle,
    super.onChanged,
    super.validator,
    super.label,
    super.topText,
    super.spacing,
    super.defaultValue = false,
    super.child,
  });
}
