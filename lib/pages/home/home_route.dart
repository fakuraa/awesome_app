import 'package:awesome_app/pages/home/home_binding.dart';
import 'package:awesome_app/pages/home/home_page.dart';
import 'package:get/get.dart';

final homeRoute = [
  GetPage(
    name: HomePage.route,
    page: () => const HomePage(),
    binding: HomeBinding(),
  ),
];
