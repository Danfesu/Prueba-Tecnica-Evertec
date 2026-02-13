import 'package:evertec_technical_test/features/main_layout/domain/entities/item_page.dart';

abstract class MainLayoutRepository {
  Future<List<ItemPage>> getPages();
}
