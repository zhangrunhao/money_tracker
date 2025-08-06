import 'package:flutter/material.dart';
import 'package:money_tracker/pages/record_page/category_select.dart';

class RecordPage extends StatelessWidget {
  const RecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('record')),
      body: Column(children: [CategorySelect()]),
    );
  }
}
