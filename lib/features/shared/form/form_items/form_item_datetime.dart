import 'package:evertec_technical_test/features/shared/form/form_items/form_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

// Clase para el elemento de fecha y hora en el formulario
// hintText: texto de sugerencia que se muestra dentro del campo
// prefixIcon: icono que se muestra al inicio del campo
// format: formato de fecha y hora (por ejemplo, DateFormat('yyyy-MM-dd HH:mm'))
// firstDate: fecha mínima seleccionable
// lastDate: fecha máxima seleccionable
// initialValue: valor inicial del campo
// inputType: tipo de entrada (fecha, hora o fecha y hora)
class FormItemDateTime extends FormItem<DateTime> {
  final String? hintText;
  final IconData? prefixIcon;
  final DateFormat? format;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialValue;
  final InputType? inputType;

  FormItemDateTime({
    required super.name,
    this.hintText,
    this.prefixIcon,
    this.format,
    this.firstDate,
    this.lastDate,
    this.initialValue,
    this.inputType,
    super.onChanged,
    super.validator,
    super.label,
    super.topText,
    super.spacing,
    super.defaultValue,
    super.child,
  });
}
