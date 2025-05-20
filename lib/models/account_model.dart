enum AccountType { stored, debt }

class AccountModel {
  final String id;
  final String name;
  final int balance;
  final AccountType type;

  AccountModel({
    required this.id,
    required this.name,
    required this.balance,
    required this.type,
  });

  String balanceString() {
    return (balance / 100).toStringAsFixed(2);
  }

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json["id"],
      name: json['name'],
      balance: json['balance'],
      type: AccountType.values.firstWhere(
        (element) => element.name == json['type'],
      ),
    );
  }
}
