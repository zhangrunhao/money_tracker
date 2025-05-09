import 'package:flutter/material.dart';

class AccountDetailPage extends StatelessWidget {
  const AccountDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('account detail')),
      body: Column(
        children: [
          const _AccountOverviewBanner(money: 200),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.attach_money),
                  title: Text('记录项 $index'),
                  subtitle: const Text('详情描述'),
                );
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

class _MonthRecordArray extends StatelessWidget {
  final List<Record> records;
  final String month;

  const _MonthRecordArray({required this.records, required this.month});
  @override
  Widget build(BuildContext context) {
    return Expanded(child: ListView.builder(
      itemCount: records.length,
      itemBuilder: (context) => {
        final 

      },

    ));
  }
}

class _RecordItem extends StatelessWidget {
  final Record record;

  const _RecordItem({required this.record});

  @override
  Widget build(BuildContext context) {
    return Row();
  }
}
