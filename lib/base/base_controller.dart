import 'package:awesome_app/base/refresher_status.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseController<T> extends GetxController {
  T? dataObj;
  RxList<T> dataList = RxList<T>([]);

  Rx<int> page = Rx(1);
  Rx<bool> hasNext = Rx(false);
  Rx<int> perPage = Rx(20);

  get statusData;
  bool get isUsingList => statusData is List;

  var cancelToken = CancelToken();
  void refreshPage();
  void loadNextPage() {}
  Rx<RefresherStatus> status = Rx(RefresherStatus.initial);

  bool get isInitial => status.value == RefresherStatus.initial;
  bool get isLoading => status.value == RefresherStatus.loading;
  bool get isShimmering => isLoading && isEmptyData;
  bool get isEmptyData => isUsingList ? dataList.isEmpty : dataObj == null;
  bool get isSuccess => status.value == RefresherStatus.success;
  bool get isError => status.value == RefresherStatus.failed && isEmptyData;

  void loadingState() {
    status.value = RefresherStatus.loading;
    update();
  }

  void successState() {
    status.value = RefresherStatus.success;
    update();
  }

  void emptyState() {
    status.value = RefresherStatus.empty;
    update();
  }

  void errorState() {
    status.value = RefresherStatus.failed;
    update();
  }

  void showError({required String errorMessage}) {
    Get.closeCurrentSnackbar();
    Get.rawSnackbar(
      backgroundColor: Colors.red.shade300,
      borderRadius: 8,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.all(16),
      snackPosition: SnackPosition.TOP,
      titleText: Text(
        "Oops",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      messageText: Text(
        errorMessage,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}
