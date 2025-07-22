import 'package:isar/isar.dart';

part 'account_model.g.dart';

/// 账户类型：资产 or 负债
enum AccountType { stored, debt }

// 账户表
@collection
class AccountModel {
  // Isar 本地自增主键
  Id isarId = Isar.autoIncrement;

  // 增加索引，提高查询速度， unique: true. 表示这个表里，这个字段不会重复
  @Index(unique: true)
  late String id;

  // 账户名称，如 “现金”、“信用卡”
  // late 字段表示初始化后，马上会进行赋值，如果不给的话，会报错
  late String name;

  /// 账户类型：资产 or 负债
  @Enumerated(EnumType.name)
  late AccountType type;

  /// 当前余额，单位分
  /// 没有late就表示了，有一个默认值，在new的时候，直接赋值了。
  int balance = 0;

  /// 创建时间
  /// 带一个？表示有可能是null, 这里其实并不合理。不应该是null, 必须有创建时间
  /// DateTime? createTime;
  late DateTime createTime;

  AccountModel();
}
