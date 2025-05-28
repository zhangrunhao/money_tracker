import 'package:money_tracker/models/record_model.dart';

class MonthRecordModel {
  final String month;
  final List<RecordModel> records;

  MonthRecordModel(this.month, this.records);
}
