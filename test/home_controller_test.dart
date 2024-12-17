import 'package:awesome_app/pages/home/home_controller.dart';
import 'package:awesome_app/base/base_response.dart';
import 'package:awesome_app/model/picture.dart';
import 'package:awesome_app/model/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:get/get.dart';

class MockApiCore extends Mock {
  Future<BaseResponse> get<T>({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    dynamic fromJson,
  });
}

class MockBox extends Mock implements Box<Storage> {}

void main() {
  late HomeController homeController;
  late MockApiCore mockApiCore;
  late MockBox mockBox;
  WidgetsFlutterBinding.ensureInitialized();
  setUp(() async {
    await Hive.initFlutter();

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (MethodCall methodCall) async {
        if (methodCall.method == 'getApplicationDocumentsDirectory') {
          return '/mock/directory';
        }
        return null;
      },
    );

    mockBox = MockBox();
    when(Hive.openBox<Storage>("Storage")).thenAnswer((_) async => mockBox);

    mockApiCore = MockApiCore();
    homeController = HomeController();
    homeController.page.value = 1;
    homeController.hasNext.value = false;
  });

  tearDown(() async {
    await Hive.close();
  });

  group('HomeController Unit Tests', () {
    test('Initial state is correct ✅', () {
      expect(homeController.viewMenu, 0);
      expect(homeController.page.value, 1);
      expect(homeController.hasNext.value, false);
      expect(homeController.dataList.length, 0);
    });

    test('Refresh Page should call loadData', () async {
      when(mockApiCore.get<Response>(
        endpoint: "/curated",
        queryParameters: anyNamed('queryParameters'),
        fromJson: anyNamed('fromJson'),
      )).thenAnswer((_) async => BaseResponse(
            status: 200,
            message: 'Request was successful',
            domain: 'api.example.com',
            data: [],
          ));

      await homeController.refreshPage();

      expect(homeController.page.value, 1);
      expect(homeController.dataList.isEmpty, true);
      verify(mockApiCore.get<Response>(
        endpoint: '/curated',
        queryParameters: {'page': 1, 'perPage': 20},
      )).called(1);
    });

    test('Load more data should append results', () async {
      final mockPictures = [
        Picture(id: 1, src: null),
        Picture(id: 2, src: null),
      ];

      when(mockApiCore.get<Response>(
        endpoint: "/curated",
        queryParameters: anyNamed('queryParameters'),
        fromJson: anyNamed('fromJson'),
      )).thenAnswer((_) async => BaseResponse(
            data: mockPictures,
            status: 200,
            message: 'Request was successful',
            domain: 'api.example.com',
          ));

      homeController.page.value = 1;
      await homeController.loadData();
      homeController.loadMore();

      expect(homeController.page.value, 2);
      expect(homeController.dataList.length, mockPictures.length);
      verify(mockApiCore.get<Response>(
        endpoint: '/curated',
        queryParameters: {'page': 2, 'perPage': 20},
      )).called(1);
    });

    test('Cache retrieval should load data from storage', () async {
      final mockCache = Storage(
          key: 'Picture', expiredDate: null, value: '[{"id": 1, "src": null}]');
      when(mockBox.get(any)).thenReturn(mockCache);

      await homeController.getCache();

      expect(homeController.dataList.length, 1);
      expect(homeController.dataList[0].id, 1);
    });
  });
}
