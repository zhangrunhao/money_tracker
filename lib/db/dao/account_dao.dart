// lib/db/dao/account_dao.dart

import 'package:money_tracker/db/isar_service.dart';
import 'package:money_tracker/db/models/account_model.dart';
import 'package:isar/isar.dart';

class AccountDao {
  final Future<Isar> _db = isarService.db;

  /// 查询所有账户，按创建时间升序
  Future<List<AccountModel>> getAllAccounts() async {
    final isar = await _db;
    return await isar.accountModels
        .where()
        .sortByCreateTime()
        .findAll();
  }

  /// 监听账户列表的变化（实时更新）
  Stream<List<AccountModel>> watchAllAccounts() async* {
    final isar = await _db;
    yield* isar.accountModels
        .where()
        .sortByCreateTime()
        .watch(fireImmediately: true);
  }

  /// 根据 isar 自增主键删除账户
  Future<void> deleteById(int isarId) async {
    final isar = await _db;
    await isar.writeTxn(() => isar.accountModels.delete(isarId));
  }

  /// 根据业务 uuid 删除账户
  Future<void> deleteByUuid(String uuid) async {
    final isar = await _db;
    final account = await isar.accountModels
        .filter()
        .uuidEqualTo(uuid)
        .findFirst();
    if (account != null) {
      await isar.writeTxn(() => isar.accountModels.delete(account.id));
    }
  }

  /// 插入或更新一条账户（upsert）
  Future<void> upsertAccount(AccountModel account) async {
    final isar = await _db;
    await isar.writeTxn(() async {
      await isar.accountModels.put(account);
    });
  }

  /// 根据 uuid 查找单条账户
  Future<AccountModel?> findByUuid(String uuid) async {
    final isar = await _db;
    return isar.accountModels
        .filter()
        .uuidEqualTo(uuid)
        .findFirst();
  }

  /// 更新指定账户的余额
  Future<void> updateBalance(String uuid, int newBalance) async {
    final isar = await _db;
    final account = await findByUuid(uuid);
    if (account != null) {
      account.balance = newBalance;
      account.createTime ??= DateTime.now();
      await isar.writeTxn(() => isar.accountModels.put(account));
    }
  }
}