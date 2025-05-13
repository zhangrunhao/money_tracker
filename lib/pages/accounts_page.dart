import 'package:flutter/material.dart';
import 'package:money_tracker/models/account.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('账户列表')),
      body: ListView.builder(
        itemCount: 5, // 这里先写死5个账户，后续可接入实际数据
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.account_balance_wallet),
            title: Text('账户 $index'),
            subtitle: const Text('余额：¥0.00'),
            onTap: () {
              Navigator.pushNamed(context, '/accountDetail', arguments: index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 可跳转到添加账户的页面或弹出对话框
          Navigator.pushNamed(context, '/record');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _AccountItem extends StatelessWidget {
  final AccountModel _account;

  const _AccountItem({super.key, required this._account});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Row(children: [Icon(Icons.book)]),
    );
  }
}
