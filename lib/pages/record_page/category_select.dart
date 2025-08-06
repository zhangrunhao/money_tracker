import 'package:flutter/material.dart';
import 'package:money_tracker/db/dao/category_dao.dart';
import 'package:money_tracker/db/models/category_model.dart';

class CategorySelect extends StatefulWidget {
  const CategorySelect({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CategorySelectState();
  }
}

class _CategorySelectState extends State {
  List<CategoryModel> cates = [];
  CategoryModel? cateAcitve;

  @override
  void initState() {
    super.initState();
    CategoryDao().getAllCategroies().then((value) {
      setState(() {
        cates = value;
      });
    });
  }

  void onCategorySelect(CategoryModel cate) {
    setState(() {
      cateAcitve = cate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children:
            cates.map((e) {
              return GestureDetector(
                onTap: () {
                  onCategorySelect(e);
                },
                child: _CategorySelectItem(cate: e, isActive: cateAcitve == e),
              );
            }).toList(),
      ),
    );
  }
}

class _CategorySelectItem extends StatelessWidget {
  final bool isActive;
  final CategoryModel cate;

  const _CategorySelectItem({required this.cate, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.museum),
        Text(
          cate.name,
          style: TextStyle(color: isActive ? Colors.red : Colors.grey),
        ),
      ],
    );
  }
}
