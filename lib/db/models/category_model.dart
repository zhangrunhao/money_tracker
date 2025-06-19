import 'package:isar/isar.dart';

part 'category_model.g.dart';

enum CategoryType { add, subtract }

@collection
class CategoryModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  late String name;

  @Enumerated(EnumType.name)
  late CategoryType type;

  String? icon;
}