import 'package:flutter/material.dart';

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

class AccountDetailPage extends StatelessWidget {
  const AccountDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('account detail')),
      body: Column(
        children: [
          // Banner section
          const _AccountOverviewBanner(money: 200),
          // Records list
          Expanded(
            child: ListView.builder(
              itemCount: 10, // 临时写死 10 条记录
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.attach_money),
                  title: Text('记录项 \$index'),
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
