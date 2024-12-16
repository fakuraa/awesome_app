import 'package:awesome_app/initializer.dart';
import 'package:awesome_app/themes/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

Future<void> main() async {
  if (kDebugMode) {
    debugPrint = (String? message, {int? wrapWidth}) =>
        debugPrintSynchronously(message, wrapWidth: wrapWidth);
  } else {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  WidgetsFlutterBinding.ensureInitialized();
  await Initializer.init();
  runApp(const AwesomeApp());
}

class AwesomeApp extends StatelessWidget {
  const AwesomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "",
      getPages: [],
      theme: AppTheme.buildThemeData(false),
    );
  }
}
