import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'models/record_model.dart';
import 'models/account_model.dart';
import 'models/category_model.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = _initDb();
  }

  Future<Isar> _initDb() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open(
      [
        RecordModelSchema,
        AccountModelSchema,
        CategoryModelSchema,
      ],
      directory: dir.path,
    );
  }
}

final isarService = IsarService();