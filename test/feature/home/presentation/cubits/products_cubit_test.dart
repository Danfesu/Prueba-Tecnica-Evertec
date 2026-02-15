// test/features/home/presentation/cubits/products_cubit_test.dart

import 'package:bloc_test/bloc_test.dart';
import 'package:evertec_technical_test/core/errors/failures.dart';
import 'package:evertec_technical_test/core/services/network/network_info.dart';
import 'package:evertec_technical_test/features/home/data/datasources/products_local_datasorce.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:evertec_technical_test/features/home/domain/usecases/get_all_products.dart';
import 'package:evertec_technical_test/features/home/domain/usecases/sync_products.dart';
import 'package:evertec_technical_test/features/home/presentation/cubits/products/products_cubit.dart';
import 'package:evertec_technical_test/features/home/presentation/cubits/products/products_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

// 🔥 1. Crear Mocks
class MockGetProducts extends Mock implements GetAllProducts {}

class MockSyncProducts extends Mock implements SyncProducts {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockProductLocalDataSource extends Mock
    implements ProductLocalDataSource {}

void main() {
  late ProductsCubit cubit;
  late MockGetProducts mockGetProducts;
  late MockSyncProducts mockSyncProducts;
  late MockNetworkInfo mockNetworkInfo;
  late MockProductLocalDataSource mockProductLocalDataSource;

  setUp(() {
    mockGetProducts = MockGetProducts();
    mockSyncProducts = MockSyncProducts();
    mockNetworkInfo = MockNetworkInfo();
    mockProductLocalDataSource = MockProductLocalDataSource();

    cubit = ProductsCubit(
      mockGetProducts,
      mockSyncProducts,
      mockNetworkInfo,
      mockProductLocalDataSource,
    );
  });

  tearDown(() {
    cubit.close();
  });

  // 🔥 Datos de prueba
  final tProducts = [
    Product(
      id: 1,
      title: 'Test Product',
      price: 99.99,
      description: 'Test',
      category: 'electronics',
      imageUrl: 'https://test.com/image.jpg',
      width: 10,
      height: 20,
      depth: 30,
      tags: [],
    ),
  ];

  group('ProductsCubit', () {
    // 🔥 Test 1: Estado inicial
    test('estado inicial debe ser ProductsState.initial()', () {
      expect(cubit.state, equals(const ProductsState.initial()));
    });

    // 🔥 Test 2: loadProducts exitoso
    blocTest<ProductsCubit, ProductsState>(
      'debe emitir [loading, loaded] cuando loadProducts es exitoso',
      build: () {
        when(() => mockGetProducts()).thenAnswer((_) async => Right(tProducts));
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          () => mockProductLocalDataSource.hasCachedData(),
        ).thenAnswer((_) async => true);
        return cubit;
      },
      act: (cubit) => cubit.loadProducts(),
      expect: () => [
        const ProductsState.loading(),
        ProductsState.loaded(
          products: tProducts,
          isOffline: false,
          isFromCache: false,
        ),
      ],
      verify: (_) {
        verify(() => mockGetProducts()).called(1);
      },
    );

    // 🔥 Test 3: loadProducts con error
    blocTest<ProductsCubit, ProductsState>(
      'debe emitir [loading, error] cuando loadProducts falla',
      build: () {
        when(
          () => mockGetProducts(),
        ).thenAnswer((_) async => Left(ServerFailure('Error de servidor')));
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          () => mockProductLocalDataSource.hasCachedData(),
        ).thenAnswer((_) async => false);
        return cubit;
      },
      act: (cubit) => cubit.loadProducts(),
      expect: () => [
        const ProductsState.loading(),
        const ProductsState.error(
          message: 'Error de servidor',
          isOffline: false,
        ),
      ],
    );

    // 🔥 Test 4: loadProducts con NetworkFailure
    blocTest<ProductsCubit, ProductsState>(
      'debe emitir error con isOffline=true cuando hay NetworkFailure',
      build: () {
        when(
          () => mockGetProducts(),
        ).thenAnswer((_) async => Left(NetworkFailure('Sin conexión')));
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(
          () => mockProductLocalDataSource.hasCachedData(),
        ).thenAnswer((_) async => false);
        return cubit;
      },
      act: (cubit) => cubit.loadProducts(),
      expect: () => [
        const ProductsState.loading(),
        const ProductsState.error(message: 'Sin conexión', isOffline: true),
      ],
    );

    // 🔥 Test 5: retry después de error
    blocTest<ProductsCubit, ProductsState>(
      'debe poder hacer retry después de un error',
      build: () {
        when(() => mockGetProducts()).thenAnswer((_) async => Right(tProducts));
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          () => mockProductLocalDataSource.hasCachedData(),
        ).thenAnswer((_) async => false);
        return cubit;
      },
      seed: () =>
          const ProductsState.error(message: 'Error previo', isOffline: false),
      act: (cubit) => cubit.retry(),
      expect: () => [
        const ProductsState.loading(),
        ProductsState.loaded(
          products: tProducts,
          isOffline: false,
          isFromCache: false,
        ),
      ],
    );

    // 🔥 Test 6: synchronizeProducts desde estado loaded
    blocTest<ProductsCubit, ProductsState>(
      'debe sincronizar productos cuando está en estado loaded',
      build: () {
        when(() => mockGetProducts()).thenAnswer((_) async => Right(tProducts));
        when(() => mockSyncProducts()).thenAnswer((_) async => Right(true));
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          () => mockProductLocalDataSource.hasCachedData(),
        ).thenAnswer((_) async => false);
        return cubit;
      },
      seed: () => ProductsState.loaded(
        products: tProducts,
        isOffline: true,
        isFromCache: true,
      ),
      act: (cubit) => cubit.synchronizeProducts(),
      expect: () => [
        ProductsState.syncing(currentProducts: tProducts),
        ProductsState.loaded(
          products: tProducts,
          isOffline: false,
          isFromCache: false,
        ),
      ],
    );

    // 🔥 Test 7: múltiples llamadas rápidas (debounce)
    blocTest<ProductsCubit, ProductsState>(
      'debe manejar múltiples llamadas sin conflictos',
      build: () {
        when(() => mockGetProducts()).thenAnswer((_) async => Right(tProducts));
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          () => mockProductLocalDataSource.hasCachedData(),
        ).thenAnswer((_) async => false);
        return cubit;
      },
      act: (cubit) async {
        cubit.loadProducts();
        await Future.delayed(Duration(milliseconds: 100));
        cubit.loadProducts();
      },
      expect: () => [
        const ProductsState.loading(),
        ProductsState.loaded(
          products: tProducts,
          isOffline: false,
          isFromCache: false,
        ),
        const ProductsState.loading(),
        ProductsState.loaded(
          products: tProducts,
          isOffline: false,
          isFromCache: false,
        ),
      ],
    );
  });
}
