import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    return '.';
  }

  @override
  Future<String?> getApplicationSupportPath() async {
    return '.';
  }

  @override
  Future<String?> getApplicationCachePath() {
    throw ".";
  }

  @override
  Future<String?> getDownloadsPath() {
    throw ".";
  }

  @override
  Future<List<String>?> getExternalCachePaths() {
    throw ".";
  }

  @override
  Future<String?> getExternalStoragePath() {
    throw ".";
  }

  @override
  Future<List<String>?> getExternalStoragePaths({StorageDirectory? type}) {
    throw ".";
  }

  @override
  Future<String?> getLibraryPath() {
    throw ".";
  }

  @override
  Future<String?> getTemporaryPath() {
    throw ".";
  }
}
