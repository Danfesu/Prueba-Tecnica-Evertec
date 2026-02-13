import 'package:evertec_technical_test/features/shared/form/form_items/form_item.dart';
import 'package:evertec_technical_test/features/shared/form/form_items/form_item_datetime.dart';
import 'package:evertec_technical_test/features/shared/form/form_items/form_item_group.dart';
import 'package:evertec_technical_test/features/shared/form/form_items/form_item_radio_group.dart';
import 'package:evertec_technical_test/features/shared/form/form_items/form_item_select.dart';
import 'package:evertec_technical_test/features/shared/form/form_items/form_item_string.dart';
import 'package:evertec_technical_test/features/shared/form/form_items/form_item_switch.dart';
import 'package:evertec_technical_test/features/shared/form/inputs/custom_builder_datetime.dart';
import 'package:evertec_technical_test/features/shared/form/inputs/custom_builder_drop_down.dart';
import 'package:evertec_technical_test/features/shared/form/inputs/custom_builder_ratio_group.dart';
import 'package:evertec_technical_test/features/shared/form/inputs/custom_builder_switch.dart';
import 'package:evertec_technical_test/features/shared/form/inputs/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Clase para construir un formulario personalizado a partir de una configuración de elementos (formConfiguration)
// formConfiguration: lista de elementos del formulario (pueden ser de diferentes tipos, como texto, dropdown, radio, switch, etc.)
// formKey: clave global para manejar el estado del formulario (validación, guardado, etc.)
class CustomFormGeneral extends StatelessWidget {
  final List<FormItem> formConfiguration;
  final GlobalKey<FormBuilderState> formKey;

  const CustomFormGeneral({
    super.key,
    required this.formConfiguration,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          for (final formItem in formConfiguration)
            // Si el elemento es un grupo, se muestra en una fila con el espacio definido entre los elementos
            if (formItem is FormItemGroup)
              Row(
                spacing: formItem.spacingBetweenItems,
                children: [
                  ...formItem.items.map(
                    (item) => Expanded(child: _buildFormItem(item)),
                  ),
                ],
              )
            else
              _buildFormItem(formItem),
        ],
      ),
    );
  }

  // Método para construir el widget correspondiente a cada tipo de elemento del formulario
  Widget _buildFormItem(FormItem formItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (formItem.topText != null) Text(formItem.topText!),
        const SizedBox(height: 8),
        if (formItem is FormItemString) CustomTextFormField(formItem: formItem),
        if (formItem is FormItemSelect)
          CustomBuilderDropDown(formItem: formItem),
        if (formItem is FormItemRadioGroup)
          CustomBuilderRatioGroup(formItem: formItem),
        if (formItem is FormItemSwitch) CustomBuilderSwitch(formItem: formItem),
        if (formItem is FormItemDateTime)
          CustomBuilderDatetime(formItem: formItem),
        SizedBox(height: formItem.spacing),
        if (formItem.child != null) formItem.child!,
      ],
    );
  }
}
