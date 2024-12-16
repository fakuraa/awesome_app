import 'dart:io';

import 'package:awesome_app/model/storage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class Initializer {
  static Future<void> init() async {
    try {
      await Initializer.initHive();
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> initHive() async {
    Directory dir = Directory("");
    if (Platform.isIOS) {
      dir = await getLibraryDirectory();
    } else {
      dir = await getApplicationDocumentsDirectory();
    }
    debugPrint("Hive Save to Location : ${dir.path}");
    Hive
      ..init(dir.path)
      ..registerAdapter(StorageAdapter());
    await Hive.openBox<Storage>((Storage).toString());
  }
}
