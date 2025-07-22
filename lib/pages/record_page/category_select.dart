import 'package:flutter/material.dart';
import 'package:money_tracker/db/models/category_model.dart';

class CategorySelect extends StatelessWidget {
  final List<CategoryModel> cates;
  final CategoryModel cateAcitve;

  const CategorySelect(this.cates, this.cateAcitve, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cates.length,
      itemBuilder: (BuildContext context, int index) {
        return _CategorySelectItem(
          cate: cates[index],
          key: ValueKey(cates[index].id),
        );
      },
    );
  }
}

class _CategorySelectItem extends StatelessWidget {
  final CategoryModel cate;

  const _CategorySelectItem({required this.cate, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [Icon(Icons.museum), Text(cate.name)]);
  }
}
