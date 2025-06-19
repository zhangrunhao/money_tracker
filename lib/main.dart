import 'package:flutter/material.dart';
import 'package:money_tracker/db/initial_data.dart';
import 'package:money_tracker/pages/account_detail_page.dart';
import 'package:money_tracker/pages/account_list_page.dart';
import 'package:money_tracker/pages/record_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {
        '/': (context) => AccountListPage(),
        '/accountDetail': (context) => AccountDetailPage(),
        '/record': (context) => RecordPage(),
      },
    );
  }
}
