import 'package:isar/isar.dart';

part 'record_model.g.dart';

@collection
class RecordModel {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true)
  late String id;

  late String name;
  late String desc;

  late int money;

  late int accountId;

  // 收入还是支出，跟着分类来
  late int categoryId;

  late DateTime createTime;
  late DateTime updateTime;

  RecordModel();
}
