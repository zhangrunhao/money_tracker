// lib/db/dao/record_dao.dart

import 'package:isar/isar.dart';
import 'package:money_tracker/db/isar_service.dart';
import 'package:money_tracker/db/models/account_model.dart';
import 'package:money_tracker/db/models/category_model.dart';
import 'package:money_tracker/db/models/record_model.dart';

class RecordDao {
  final Future<Isar> _db = isarService.db;

  /// 分页查询：按 createTime 倒序，支持跳页
  Future<List<RecordModel>> queryRecordsPage({
    required int page,
    int pageSize = 20,
  }) async {
    final isar = await _db;
    final offset = page * pageSize;
    return isar.recordModels
        .where()
        .sortByCreateTimeDesc()
        .offset(offset)
        .limit(pageSize)
        .findAll();
  }

  /// 查询所有记录（按时间倒序）
  Future<List<RecordModel>> getAllRecords() async {
    final isar = await _db;
    return isar.recordModels
        .where()
        .sortByCreateTimeDesc()
        .findAll();
  }

  /// 监听所有记录的变化（UI 实时更新）
  Stream<List<RecordModel>> watchAllRecords() async* {
    final isar = await _db;
    yield* isar.recordModels
        .where()
        .sortByCreateTimeDesc()
        .watch(fireImmediately: true);
  }
}