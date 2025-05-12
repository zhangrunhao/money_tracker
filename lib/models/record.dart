enum RecordSign { add, subtract }

class RecordModel {
  final String id;
  final String name;
  final String desc;
  final String icon;
  final RecordSign sign; // add, subtract
  final int money;
  final DateTime createTime;
  final DateTime updateTime;

  RecordModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.icon,
    required this.sign, // add, subtract
    required this.money,
    required this.createTime,
    required this.updateTime,
  });

  factory RecordModel.fromJson(Map<String, dynamic> json) {
    return RecordModel(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      icon: json['icon'],
      sign: RecordSign.values.firstWhere(
        (element) => element.name == json['sign'],
      ),
      money: json['money'],
      createTime: DateTime.fromMicrosecondsSinceEpoch(
        json['createTime'] * 1000,
      ),
      updateTime: DateTime.fromMicrosecondsSinceEpoch(
        json['updateTime'] * 1000,
      ),
    );
  }
}
