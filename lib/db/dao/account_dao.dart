// lib/db/dao/account_dao.dart

import 'package:money_tracker/db/isar_service.dart';
import 'package:money_tracker/db/models/account_model.dart';
import 'package:isar/isar.dart';

class AccountDao {
  final Future<Isar> _db = isarService.db;

  /// 查询所有账户，按创建时间升序
  Future<List<AccountModel>> getAllAccounts() async {
    final isar = await _db;
    return await isar.accountModels.where().sortByCreateTime().findAll();
  }

  /// 监听账户列表的变化（实时更新）
  Stream<List<AccountModel>> watchAllAccounts() async* {
    final isar = await _db;
    yield* isar.accountModels.where().sortByCreateTime().watch(
      fireImmediately: true,
    );
  }
}
