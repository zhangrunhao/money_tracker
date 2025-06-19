import 'package:isar/isar.dart';

part 'account_model.g.dart';

/// 账户类型：资产 or 负债
enum AccountType { stored, debt }

@collection
class AccountModel {
  /// Isar 本地自增主键
  Id id = Isar.autoIncrement;

  /// 业务层全局唯一 ID（UUID）
  @Index(unique: true)
  late String uuid;

  /// 账户名称，如 “现金”、“信用卡”
  late String name;

  /// 账户类型：资产 or 负债
  @Enumerated(EnumType.name)
  late AccountType type;

  /// 当前余额，单位分
  int balance = 0;

  /// 创建时间
  DateTime? createTime;

  AccountModel();
}
