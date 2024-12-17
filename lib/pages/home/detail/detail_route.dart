import 'package:awesome_app/model/picture.dart';
import 'package:awesome_app/pages/home/detail/detail_page.dart';
import 'package:get/get.dart';

final detailRoute = [
  GetPage(
    name: DetailPage.route,
    page: () => DetailPage(Picture.fromJson(Get.arguments)),
  ),
];
