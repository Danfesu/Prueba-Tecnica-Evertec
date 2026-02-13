import 'package:evertec_technical_test/features/main_layout/domain/entities/item_page.dart';

abstract class MainLayoutDatasource {
  Future<List<ItemPage>> getPages();
}
