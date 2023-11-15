import 'package:flutter/material.dart';
import 'package:schuldaten_hub/features/goal/views/category_list_view/category_list_view.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({
    Key? key,
  }) : super(key: key);

  @override
  CategoryListController createState() => CategoryListController();
}

class CategoryListController extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return CategoryListView(this);
  }
}
