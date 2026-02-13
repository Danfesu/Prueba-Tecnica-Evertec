import 'package:evertec_technical_test/features/shared/form/form_items/form_item.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Clase para el elemento de grupo de opciones (radio buttons) en el formulario
// options: lista de opciones para el grupo de radio buttons
// orientation: orientación de las opciones (horizontal o vertical)
// activeColor: color del radio button seleccionado
// controlAffinity: posición del radio button con respecto al texto (leading o trailing)
class FormItemRadioGroup extends FormItem<String> {
  final List<String> options;
  final OptionsOrientation orientation;
  final Color activeColor;
  final ControlAffinity controlAffinity;

  FormItemRadioGroup({
    required super.name,
    required this.options,
    this.orientation = OptionsOrientation.horizontal,
    required this.activeColor,
    this.controlAffinity = ControlAffinity.leading,
    super.onChanged,
    super.validator,
    super.label,
    super.topText,
    super.spacing,
    super.defaultValue,
    super.child,
  });
}
