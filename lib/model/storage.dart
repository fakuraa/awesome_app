import 'package:hive/hive.dart';
import 'package:awesome_app/utils/hive_helper/hive_types.dart';
import 'package:awesome_app/utils/hive_helper/hive_adapters.dart';
import 'package:awesome_app/utils/hive_helper/fields/storage_fields.dart';

part 'storage.g.dart';

@HiveType(typeId: HiveTypes.storage, adapterName: HiveAdapters.storage)
class Storage extends HiveObject {
  Storage({required this.key, required this.value, this.expiredDate});

  @override
  @HiveField(StorageFields.key)
  final String key;
  @HiveField(StorageFields.value)
  final dynamic value;
  @HiveField(StorageFields.expiredDate)
  final DateTime? expiredDate;

  factory Storage.fromJson(Map<String, dynamic> json) => Storage(
        key: json["key"],
        value: json["value"],
        expiredDate: json["expiredDate"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
        "expiredDate": expiredDate,
      };
}
