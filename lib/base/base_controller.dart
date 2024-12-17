import 'package:awesome_app/base/refresher_status.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

abstract class BaseController<T> extends GetxController {
  T? dataObj;
  RxList<T> dataList = RxList<T>([]);

  Rx<int> page = Rx(1);
  Rx<bool> hasNext = Rx(false);
  Rx<int> perPage = Rx(10);

  get statusData;
  bool get isUsingList => statusData is List;

  final cancelToken = CancelToken();
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
}
