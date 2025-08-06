import 'package:money_tracker/db/isar_service.dart';
import 'package:money_tracker/db/models/category_model.dart';
import 'package:isar/isar.dart';

class CategoryDao {
  final Future<Isar> _db = isarService.db;

  Future<List<CategoryModel>> getAllCategroies() async {
    final isar = await _db;
    return await isar.categoryModels.where().findAll();
  }
}
