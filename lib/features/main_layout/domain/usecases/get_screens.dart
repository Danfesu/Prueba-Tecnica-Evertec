import 'package:evertec_technical_test/features/main_layout/domain/entities/item_page.dart';
import 'package:evertec_technical_test/features/main_layout/domain/repositories/main_layout_repository.dart';

class GetScreens {
  final MainLayoutRepository repository;
  GetScreens(this.repository);

  Future<List<ItemPage>> call() {
    return repository.getPages();
  }
}
