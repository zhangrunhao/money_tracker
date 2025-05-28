import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_tracker/models/month_record_model.dart';
import 'package:money_tracker/models/record_model.dart';
import 'package:money_tracker/provider/records_provider.dart';
import 'package:provider/provider.dart';

class AccountDetailPage extends StatelessWidget {
  const AccountDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('account detail')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/record');
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const _AccountOverviewBanner(money: 200),
          Expanded(child: _RecordList()),
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

class _RecordList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecordListState();
}

class _RecordListState extends State {
  late final ScrollController _controller;
  late final RecordsProvider vm;

  @override
  void initState() {
    super.initState();
    vm = RecordsProvider();
    _controller =
        ScrollController()..addListener(() {
          if (_controller.position.pixels >
              _controller.position.maxScrollExtent - 200) {
            vm.loadNextPage();
          }
        });
    vm.loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: vm,
      child: Consumer<RecordsProvider>(
        builder: (_, prov, __) {
          return ListView.builder(
            controller: _controller,
            itemCount: prov.sections.length + (prov.hasMore ? 1 : 0),
            itemBuilder: (ctx, idx) {
              if (idx > prov.sections.length) {
                return CircularProgressIndicator();
              }
              final section = prov.sections[idx];
              return _MonthRecord(section: section);
            },
          );
        },
      ),
    );
  }
}

class _MonthRecord extends StatelessWidget {
  final MonthRecordModel section;

  const _MonthRecord({required this.section});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Container()],
    );
  }
}
