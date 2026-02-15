import 'package:evertec_technical_test/features/main_layout/data/datasources/main_layout_datasource.dart';
import 'package:evertec_technical_test/features/main_layout/domain/entities/item_page.dart';
import 'package:evertec_technical_test/features/main_layout/domain/repositories/main_layout_repository.dart';

/// Implementación concreta del repositorio para el layout principal.
///
/// Esta clase actúa como puente entre la capa de dominio
/// y la capa de datos, delegando la obtención de páginas
/// al datasource correspondiente.
///
/// Permite desacoplar la lógica de negocio de la fuente
class MainLayoutRepositoryImpl implements MainLayoutRepository {
  /// Fuente de datos utilizada para obtener las páginas.
  final MainLayoutDatasource datasource;

  /// Constructor que recibe el datasource por inyección de dependencias.
  MainLayoutRepositoryImpl(this.datasource);

  /// Obtiene la lista de páginas disponibles en el layout principal.
  ///
  /// Simplemente delega la llamada al datasource.
  /// Esto permite cambiar la fuente de datos sin afectar
  /// la capa de dominio.
  @override
  Future<List<ItemPage>> getPages() {
    return datasource.getPages();
  }
}
