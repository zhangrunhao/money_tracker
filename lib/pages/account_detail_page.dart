import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_tracker/models/record.dart';

class AccountDetailPage extends StatefulWidget {
  const AccountDetailPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AccountDetailPageState();
  }
}

class _AccountDetailPageState extends State {
  List<RecordModel> records = [];

  Future<List<RecordModel>> loadMockRecords() async {
    final String jsonString = await rootBundle.loadString(
      "assets/data/mock_records.json",
    );
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((e) => RecordModel.fromJson(e)).toList();
  }

  @override
  void initState() {
    super.initState();
    loadMockRecords().then((loaded) {
      setState(() {
        records = loaded;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('account detail')),
      body: Column(
        children: [
          const _AccountOverviewBanner(money: 200),
          Expanded(
            child: ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                return _RecordModelItem(record: records[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountOverviewBanner extends StatelessWidget {
  const _AccountOverviewBanner({required this.money});

  final int money;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      color: Colors.blueAccent,
      alignment: Alignment.center,
      child: Text(
        '¥$money',
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}

class _MonthItem extends StatelessWidget {
  final List<RecordModel> records;
  final String month;

  const _MonthItem({required this.records, required this.month});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(month),
        ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return _RecordModelItem(record: records[index]);
          },
        ),
      ],
    );
  }
}

class _RecordModelItem extends StatelessWidget {
  final RecordModel record;

  const _RecordModelItem({required this.record});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          SizedBox(width: 20, height: 20, child: Image.network(record.icon)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(record.name),
                const SizedBox(height: 4),
                Text(record.desc),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '${record.sign == RecordSign.add ? '+' : '-'}${record.money}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
