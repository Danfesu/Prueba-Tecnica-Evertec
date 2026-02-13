import 'package:evertec_technical_test/features/main_layout/data/datasources/main_layout_datasource.dart';
import 'package:evertec_technical_test/features/main_layout/domain/entities/item_page.dart';
import 'package:evertec_technical_test/features/main_layout/domain/repositories/main_layout_repository.dart';

class MainLayoutRepositoryImpl implements MainLayoutRepository {
  final MainLayoutDatasource datasource;
  MainLayoutRepositoryImpl(this.datasource);

  @override
  Future<List<ItemPage>> getPages() {
    return datasource.getPages();
  }
}
