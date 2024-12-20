import 'dart:convert';

import 'package:awesome_app/base/base_service.dart';
import 'package:awesome_app/pages/home/home_controller.dart';
import 'package:awesome_app/base/base_response.dart';
import 'package:awesome_app/model/picture.dart';
import 'package:awesome_app/model/storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'component/mock_path_provider.dart';
import 'data/mock_picture.dart';
import 'home_controller_test.mocks.dart';

@GenerateMocks([ApiCore, Box, HiveInterface])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late HomeController homeController;
  late MockApiCore mockApiCore;
  late MockBox<Storage> mockBox;
  late MockHiveInterface mockHiveWrapper;

  setUp(() async {
    PathProviderPlatform.instance = FakePathProviderPlatform();

    mockHiveWrapper = MockHiveInterface();
    mockBox = MockBox();
    mockApiCore = MockApiCore();

    mockHiveWrapper.init('.');
    when(mockHiveWrapper.openBox("Storage")).thenAnswer((_) async => mockBox);

    homeController = HomeController();
    homeController.box = mockBox;
    homeController.page.value = 1;
    homeController.hasNext.value = false;
    homeController.service = mockApiCore;
  });

  tearDown(() async {
    await mockHiveWrapper.close();
  });

  group('HomeController Unit Tests', () {
    test('Initial state is correct ✅', () {
      expect(homeController.viewMenu, 0);
      expect(homeController.page.value, 1);
      expect(homeController.perPage.value, 20);
      expect(homeController.hasNext.value, false);
      expect(homeController.dataList.isEmpty, true);
    });

    test('Cache retrieval should load data from storage', () async {
      final mockCache = Storage(
          key: homeController.cacheKey ?? "",
          expiredDate: null,
          value: json.encode([Picture(id: 1)]));
      when(mockBox.get(homeController.cacheKey)).thenReturn(mockCache);
      await homeController.getCache();
      expect(homeController.dataList.length, 1);
      expect(homeController.dataList[0].id, 1);
    });

    test('Refresh Page should call loadData', () async {
      when(mockApiCore.get(
        endpoint: anyNamed('endpoint'),
        queryParameters: anyNamed('queryParameters'),
        fromJson: anyNamed('fromJson'),
        cancelToken: anyNamed('cancelToken'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => pictureEmptyResponse);

      await homeController.refreshPage();

      expect(homeController.page.value, 1);
      expect(homeController.dataList.isEmpty, true);

      verify(mockApiCore.get<BaseResponse>(
        endpoint: '/curated',
        queryParameters: {'page': 1, 'per_page': 20},
        cancelToken: anyNamed('cancelToken'),
        fromJson: anyNamed('fromJson'),
      )).called(1);
    });

    test('Load more data should append results', () async {
      when(mockApiCore.get<BaseResponse>(
        endpoint: anyNamed('endpoint'),
        queryParameters: anyNamed('queryParameters'),
        fromJson: anyNamed('fromJson'),
        cancelToken: anyNamed('cancelToken'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => picturesResponse);

      await homeController.refreshPage();
      await homeController.loadMore();

      expect(homeController.page.value, 2);
      expect(homeController.dataList.length,
          (picturesResponse.data?.length ?? 0) * 2);

      verify(mockApiCore.get<BaseResponse>(
        endpoint: '/curated',
        queryParameters: {'page': 1, 'per_page': 20},
        cancelToken: anyNamed('cancelToken'),
        fromJson: anyNamed('fromJson'),
      )).called(1);

      verify(mockApiCore.get<BaseResponse>(
        endpoint: '/curated',
        queryParameters: {'page': 2, 'per_page': 20},
        cancelToken: anyNamed('cancelToken'),
        fromJson: anyNamed('fromJson'),
      )).called(1);
    });
  });
}
