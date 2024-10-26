import 'package:flutter/material.dart';
import 'package:money_manager/models/money_usage.dart';

class CategoryWidget extends StatelessWidget {
  final void Function()? onTap;
  final Category category;
  const CategoryWidget({
    super.key,
    this.onTap,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(category.name),
      ),
    );
  }
}
