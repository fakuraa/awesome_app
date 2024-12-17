import 'dart:convert';

import 'package:awesome_app/base/base_controller.dart';
import 'package:awesome_app/base/base_response.dart';
import 'package:awesome_app/base/base_service.dart';
import 'package:awesome_app/model/picture.dart';
import 'package:awesome_app/model/storage.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:hive/hive.dart';

class HomeController extends BaseController<Picture> {
  int viewMenu = 0;
  EasyRefreshController refreshController = EasyRefreshController();
  final _box = Hive.box<Storage>((Storage).toString());
  var cacheKey = (Picture).toString();

  @override
  void onInit() {
    super.onInit();
    getCache().then((v) => refreshPage());
  }

  @override
  get statusData => dataList;

  @override
  Future<void> refreshPage() async {
    page.value = 1;
    loadData();
    update();
  }

  void loadMore() {
    page.value += 1;
    loadData();
    update();
  }

  loadData() async {
    try {
      loadingState();
      var result = await ApiCore.call.get<Response>(
        endpoint: '/curated',
        queryParameters: {'page': page, 'perPage': perPage},
        cancelToken: cancelToken,
        fromJson: (data) => Response.fromJson(data),
      );
      hasNext.value = (result.nextPage ?? "").isNotEmpty;

      if (page.value == 1) {
        saveCacheAndFinish();
        dataList.value = result.data ?? [];
      } else {
        dataList.addAll(result.data ?? []);
      }
    } catch (error) {
      showError(errorMessage: error.toString());
    }
  }

  void changeViewMenu(int item) {
    viewMenu = item;
    update();
  }

  Future<void> getCache() async {
    var cache = _box.get(cacheKey);
    if (cache != null && cache.toString().isNotEmpty) {
      dataList.value = List<Picture>.from(
          json.decode(cache.value).map((x) => Picture.fromJson(x)));
      successState();
    }
  }

  Future<void> saveCacheAndFinish() async {
    _box.put(
        cacheKey,
        Storage(
            key: cacheKey, expiredDate: null, value: json.encode(dataList)));
    successState();
  }
}
