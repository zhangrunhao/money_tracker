class Record {
  final String id;
  final String name;
  final String desc;
  final String icon;
  final String sign; // add, subtract
  final int money;
  final DateTime createTime;
  final DateTime updateTime;

  Record({
    required this.id,
    required this.name,
    required this.desc,
    required this.icon,
    required this.sign, // add, subtract
    required this.money,
    required this.createTime,
    required this.updateTime,
  });

  String getMoneyString() {
    return (money / 100).toStringAsFixed(2);
  }
}
