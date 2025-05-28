import 'package:money_tracker/models/record_model.dart';

Future<List<RecordModel>> queryRecordsPage({
  // required Database db,
  required int page,
  int pageSize = 20,
}) async {
  // final offset = page * pageSize;
  // final maps = await db.query
  List<Map<String, dynamic>> maps = [];
  return maps.map((e) => RecordModel.fromJson(e)).toList();
}
