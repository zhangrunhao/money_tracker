// lib/db/initial_data.dart

import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:money_tracker/db/isar_service.dart';
import 'package:money_tracker/db/models/account_model.dart';
import 'package:money_tracker/db/models/category_model.dart';
import 'package:money_tracker/db/models/record_model.dart';

/// 插入默认账户、分类、示例记录
Future<void> insertDefaultData() async {
  final isar = await isarService.db;
  await isar.writeTxn(() async {
    // 1. 先判断是否已有数据，避免重复
    final accountCount = await isar.accountModels.count();
    if (accountCount == 0) {
      final uuidGen = const Uuid();
      // 插入账户
      final cash = AccountModel()
        ..uuid = uuidGen.v4()
        ..name = '现金'
        ..type = AccountType.stored
        ..balance = 0
        ..createTime = DateTime.now();
      final credit = AccountModel()
        ..uuid = uuidGen.v4()
        ..name = '信用卡'
        ..type = AccountType.debt
        ..balance = 0
        ..createTime = DateTime.now();
      await isar.accountModels.putAll([cash, credit]);

      // 插入分类
      final food = CategoryModel()
        ..uuid = uuidGen.v4()
        ..name = '餐饮'
        ..type = CategoryType.subtract;
      final salary = CategoryModel()
        ..uuid = uuidGen.v4()
        ..name = '工资'
        ..type = CategoryType.add;
      await isar.categoryModels.putAll([food, salary]);

      // 插入一条示例记录
      final sample = RecordModel()
        ..id = uuidGen.v4()
        ..name = '午餐'
        ..desc = '一碗面'
        ..icon = '🍜'
        ..sign = RecordSign.subtract
        ..money = 2500
        ..accountId = cash.id
        ..categoryId = food.id
        ..createTime = DateTime.now()
        ..updateTime = DateTime.now();
      await isar.recordModels.put(sample);
    }
  });
}