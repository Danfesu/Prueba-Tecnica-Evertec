import 'package:evertec_technical_test/core/errors/failures.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:evertec_technical_test/features/home/domain/repositories/products_repository.dart';
import 'package:evertec_technical_test/features/home/domain/usecases/get_all_products.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

// 1. Crear Mock del Repository
class MockProductRepository extends Mock implements ProductsRepository {}

void main() {
  // 2. Declarar variables
  late GetAllProducts usecase;
  late MockProductRepository mockRepository;

  // 3. setUp - Se ejecuta antes de cada test
  setUp(() {
    mockRepository = MockProductRepository();
    usecase = GetAllProducts(mockRepository);
  });

  // 🔥 4. Datos de prueba
  final tProducts = [
    Product(
      id: 1,
      title: 'Test Product 1',
      price: 99.99,
      description: 'Test description',
      category: 'electronics',
      imageUrl: 'https://test.com/image.jpg',
      width: 10,
      height: 20,
      depth: 30,
      tags: [],
    ),
    Product(
      id: 2,
      title: 'Test Product 2',
      price: 149.99,
      description: 'Test description 2',
      category: 'clothing',
      imageUrl: 'https://test.com/image2.jpg',
      width: 10,
      height: 20,
      depth: 30,
      tags: [],
    ),
  ];

  // 🔥 5. Grupo de tests
  group('GetProducts UseCase', () {
    test(
      'debe retornar lista de productos cuando el repository devuelve éxito',
      () async {
        // arrange (preparar)
        when(
          () => mockRepository.getAllProducts(),
        ).thenAnswer((_) async => Right(tProducts));

        // act (actuar)
        final result = await usecase();

        // assert (verificar)
        expect(result, Right(tProducts));
        verify(() => mockRepository.getAllProducts()).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test('debe retornar ServerFailure cuando el repository falla', () async {
      // arrange
      when(
        () => mockRepository.getAllProducts(),
      ).thenAnswer((_) async => Left(ServerFailure('Error de servidor')));

      // act
      final result = await usecase();

      // assert
      expect(result, Left(ServerFailure('Error de servidor')));
      verify(() => mockRepository.getAllProducts()).called(1);
    });

    test('debe retornar NetworkFailure cuando no hay conexión', () async {
      // arrange
      when(
        () => mockRepository.getAllProducts(),
      ).thenAnswer((_) async => Left(NetworkFailure('Sin conexión')));

      // act
      final result = await usecase();

      // assert
      expect(result, Left(NetworkFailure('Sin conexión')));
      verify(() => mockRepository.getAllProducts()).called(1);
    });

    test('debe retornar CacheFailure cuando falla el cache', () async {
      // arrange
      when(
        () => mockRepository.getAllProducts(),
      ).thenAnswer((_) async => Left(CacheFailure('Error en cache')));

      // act
      final result = await usecase();

      // assert
      result.fold(
        (failure) => expect(failure, isA<CacheFailure>()),
        (products) => fail('Debería retornar un Failure'),
      );
    });
  });
}
