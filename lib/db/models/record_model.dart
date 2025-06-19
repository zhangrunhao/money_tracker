import 'package:isar/isar.dart';

part 'record_model.g.dart';

enum RecordSign { add, subtract }

@collection
class RecordModel {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true)
  late String id;

  late String name;
  late String desc;
  late String icon;

  // 👇 加上枚举注解，保存时按字符串 name
  @Enumerated(EnumType.name)
  late RecordSign sign; // 收入 or 支出
  late int money;

  late int accountId;
  late int categoryId;

  late DateTime createTime;
  late DateTime updateTime;

  RecordModel();
}
