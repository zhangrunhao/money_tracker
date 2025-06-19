import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_tracker/db/dao/account_dao.dart';
import 'package:money_tracker/db/models/account_model.dart';

class AccountListPage extends StatefulWidget {
  const AccountListPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AccountListPageState();
  }
}

class _AccountListPageState extends State {
  List<AccountModel> storedAccounts = [];
  List<AccountModel> debtAccounts = [];

  @override
  void initState() {
    super.initState();
    AccountDao().getAllAccounts().then((v) {
      setState(() {
        storedAccounts = v.where((a) => a.type == AccountType.stored).toList();
        debtAccounts = v.where((a) => a.type == AccountType.debt).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('账户列表')),
      body: Column(
        children: [
          const SizedBox(height: 8),
          const Text('资产'),
          _AccountList(accounts: storedAccounts),
          const SizedBox(height: 26),
          const Text('负债'),
          _AccountList(accounts: debtAccounts),
        ],
      ),
    );
  }
}

class _AccountList extends StatelessWidget {
  final List<AccountModel> accounts;

  const _AccountList({required this.accounts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: accounts.length,
      itemBuilder: (context, index) => _AccountItem(account: accounts[index]),
    );
  }
}

class _AccountItem extends StatelessWidget {
  final AccountModel account;

  const _AccountItem({required this.account});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/accountDetail', arguments: account.id);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Row(
          children: [
            Icon(Icons.bolt),
            Expanded(child: Text(account.name)),
            Text(account.balance.toString()),
          ],
        ),
      ),
    );
  }
}
