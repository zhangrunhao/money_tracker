import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/db/dao/record_dao.dart';
import 'package:money_tracker/db/models/month_record_model.dart';
import 'package:money_tracker/db/models/record_model.dart';

class RecordsProvider with ChangeNotifier {
  List<MonthRecordModel> sections = [];
  final List<RecordModel> _buffer = [];
  int _page = 0;
  bool hasMore = true;

  Future<void> loadNextPage() async {
    if (!hasMore) return;
    final newRecords = await RecordDao().queryRecordsPage(page: _page);
    if (newRecords.isEmpty) {
      hasMore = false;
      return;
    }
    _page++;
    _buffer.addAll(newRecords);
    _rebuildSections();
    notifyListeners();
  }

  void _rebuildSections() {
    final Map<String, List<RecordModel>> map = {};
    for (RecordModel r in _buffer) {
      final ym = DateFormat('yyyy年MM月').format(r.updateTime);
      map.putIfAbsent(ym, () => []).add(r);
    }
    // 针对每个key
    final entries =
        map.entries.toList()..sort((a, b) => b.key.compareTo(a.key));

    sections =
        entries
            .map(
              (e) => MonthRecordModel(
                e.key,
                e.value..sort((a, b) => b.updateTime.compareTo(a.updateTime)),
              ),
            )
            .toList();
  }
}
