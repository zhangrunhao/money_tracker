import 'package:isar/isar.dart';

part 'category_model.g.dart';

// 增加金额 / 减少金额
enum CategoryType { add, subtract }

// 系统不可标记的，例如转入/转出/借入/借出等用户不可编辑的， 一进入就初始化好的
// 用户可编辑的，例如工资 / 餐饮 / 交通等用户可编辑的类型
enum SourceType { readonly, editable }

// 分类表,
@collection
class CategoryModel {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true)
  late String id;

  late String name;

  @Enumerated(EnumType.name)
  late CategoryType type;

  @Enumerated(EnumType.name)
  late SourceType sourceType;

  late String icon;
}
