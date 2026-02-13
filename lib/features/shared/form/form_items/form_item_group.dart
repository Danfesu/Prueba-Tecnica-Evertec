import 'package:evertec_technical_test/features/shared/form/form_items/form_item.dart';

// Clase para agrupar varios elementos del formulario (para mostrarlo en una sola sección)
// items: lista de elementos del formulario que se agrupan
// spacingBetweenItems: espacio entre los elementos del grupo (por defecto 8.0)
class FormItemGroup extends FormItem {
  final List<FormItem> items;
  final double spacingBetweenItems;

  FormItemGroup({
    super.name = "group",
    required this.items,
    this.spacingBetweenItems = 8.0,
  });
}
