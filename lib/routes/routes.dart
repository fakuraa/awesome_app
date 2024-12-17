import 'package:awesome_app/pages/home/detail/detail_route.dart';
import 'package:awesome_app/pages/home/home_page.dart';
import 'package:awesome_app/pages/home/home_route.dart';

class Routes {
  static const initial = HomePage.route;

  static final all = [...homeRoute, ...detailRoute];
}
