import 'package:uuid/uuid.dart';
import 'package:money_tracker/db/isar_service.dart';
import 'package:money_tracker/db/models/account_model.dart';
import 'package:money_tracker/db/models/category_model.dart';
import 'package:money_tracker/db/models/record_model.dart';

/// 重置数据库并插入初始化数据
Future<void> resetAndInsertDefaultData() async {
  final isar = await isarService.db;
  await isar.writeTxn(() async {
    // 1. 清空所有表
    await isar.recordModels.clear();
    await isar.categoryModels.clear();
    await isar.accountModels.clear();

    // 2. 准备 UUID 生成器
    final uuid = const Uuid();

    // 3. 插入默认账户
    final cash =
        AccountModel()
          ..id = uuid.v4()
          ..name = '现金'
          ..type = AccountType.stored
          ..balance = 0
          ..createTime = DateTime.now();
    final credit =
        AccountModel()
          ..id = uuid.v4()
          ..name = '信用卡'
          ..type = AccountType.debt
          ..balance = 0
          ..createTime = DateTime.now();
    await isar.accountModels.putAll([cash, credit]);

    // 4. 插入默认分类
    final food =
        CategoryModel()
          ..id = uuid.v4()
          ..name = '餐饮'
          ..type = CategoryType.subtract
          ..icon = '🍜';
    final salary =
        CategoryModel()
          ..id = uuid.v4()
          ..name = '工资'
          ..type = CategoryType.add
          ..icon = '💰';
    await isar.categoryModels.putAll([food, salary]);

    // 5. 插入一条示例记录
    // 请根据你的 RecordModel 定义调整下字段名或类型
    final sample =
        RecordModel()
          ..id = uuid.v4()
          ..name = '午餐'
          ..desc = '一碗面'
          ..money = 2500
          ..accountId = cash.isarId
          ..categoryId = food.isarId
          ..createTime = DateTime.now()
          ..updateTime = DateTime.now();
    await isar.recordModels.put(sample);
  });
}
