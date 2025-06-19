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

  /// 根据 Isar 本地主键删除
  Future<void> deleteByIsarId(int isarId) async {
    final isar = await _db;
    await isar.writeTxn(() => isar.recordModels.delete(isarId));
  }

  /// 根据业务 UUID 删除
  Future<void> deleteByUuid(String uuid) async {
    final isar = await _db;
    final record = await isar.recordModels
        .filter()
        .idEqualTo(uuid)
        .findFirst();
    if (record != null) {
      await isar.writeTxn(() => isar.recordModels.delete(record.isarId));
    }
  }

  /// 插入或更新一条记录（upsert）
  Future<void> upsertRecord(RecordModel record) async {
    final isar = await _db;
    await isar.writeTxn(() async {
      await isar.recordModels.put(record);
    });
  }

  /// 根据业务 UUID 查找单条记录
  Future<RecordModel?> findByUuid(String uuid) async {
    final isar = await _db;
    return isar.recordModels
        .filter()
        .idEqualTo(uuid)
        .findFirst();
  }

  /// 根据账户 UUID 查询该账户下的所有记录
  Future<List<RecordModel>> findByAccountUuid(String accountUuid) async {
    final isar = await _db;
    // 先拿到账户的 isarId
    final account = await isar.accountModels
        .filter()
        .uuidEqualTo(accountUuid)
        .findFirst();
    if (account == null) return [];
    return isar.recordModels
        .filter()
        .accountIdEqualTo(account.id)
        .sortByCreateTimeDesc()
        .findAll();
  }

  /// 根据分类 UUID 查询该分类下的所有记录
  Future<List<RecordModel>> findByCategoryUuid(String categoryUuid) async {
    final isar = await _db;
    final category = await isar.categoryModels
        .filter()
        .uuidEqualTo(categoryUuid)
        .findFirst();
    if (category == null) return [];
    return isar.recordModels
        .filter()
        .categoryIdEqualTo(category.id)
        .sortByCreateTimeDesc()
        .findAll();
  }

  /// 更新某条记录的备注或金额等字段
  Future<void> updateRecord(RecordModel record) async {
    final isar = await _db;
    record.updateTime = DateTime.now();
    await isar.writeTxn(() => isar.recordModels.put(record));
  }
}