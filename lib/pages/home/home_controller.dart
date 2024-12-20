import 'dart:convert';

import 'package:awesome_app/base/base_controller.dart';
import 'package:awesome_app/base/base_response.dart';
import 'package:awesome_app/model/picture.dart';
import 'package:awesome_app/model/storage.dart';

class HomeController extends BaseController<Picture> {
  int viewMenu = 0;

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

  Future<void> loadMore() async {
    page.value += 1;
    loadData();
    update();
  }

  loadData() async {
    try {
      loadingState();
      var result = await service?.get<BaseResponse>(
        endpoint: '/curated',
        queryParameters: {'page': page.value, 'per_page': perPage.value},
        cancelToken: cancelToken,
        fromJson: (data) => BaseResponse.fromJson(data),
      );
      hasNext.value = (result?.nextPage ?? "").isNotEmpty;
      if (page.value == 1) {
        saveCacheAndFinish();
        dataList.value = result?.data ?? [];
      } else {
        dataList.value = [...dataList, ...(result?.data ?? [])];
      }
      successState();
    } catch (error) {
      print('Error in loadData: $error');
      showError(errorMessage: error.toString());
    }
  }

  void changeViewMenu(int item) {
    viewMenu = item;
    update();
  }

  Future<void> getCache() async {
    var cache = box?.get(cacheKey);
    if (cache != null && cache.toString().isNotEmpty) {
      dataList.value = List<Picture>.from(
          json.decode(cache.value).map((x) => Picture.fromJson(x)));
      successState();
    }
  }

  Future<void> saveCacheAndFinish() async {
    box?.put(
        cacheKey,
        Storage(
            key: cacheKey ?? "",
            expiredDate: null,
            value: json.encode(dataList)));
  }
}
