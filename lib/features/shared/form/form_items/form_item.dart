import 'package:flutter/material.dart';

// Clase base para los elementos del formulario
// Esta clase se extiende para crear diferentes tipos de elementos (input, dropdown, radio group, etc.)
// name: nombre del campo (clave para identificar el valor en el formulario)
// onChanged: función que se ejecuta cuando el valor del campo cambia
// validator: función para validar el valor del campo
// label: etiqueta que se muestra junto al campo
// topText: texto que se muestra encima del campo (opcional)
// spacing: espacio entre campos del formulario (por defecto 8.0)
// defaultValue: valor por defecto del campo (opcional)
// child: widget personalizado que se muestra debajo del campo (opcional)
abstract class FormItem<T> {
  final String name;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final String? label;
  final String? topText;
  final double spacing;
  final T? defaultValue;
  final Widget? child;

  FormItem({
    required this.name,
    this.validator,
    this.label,
    this.topText,
    this.spacing = 8.0,
    this.child,
    this.onChanged,
    this.defaultValue,
  });
}
