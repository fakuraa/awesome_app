import 'package:hive/hive.dart';
import 'package:awesome_app/model/storage.dart';

void registerAdapters() {
	Hive.registerAdapter(StorageAdapter());
}
