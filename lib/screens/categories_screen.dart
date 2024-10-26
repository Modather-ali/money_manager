import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../bloc/money_updates_bloc.dart';
import '../models/money_usage.dart';
import 'widgets/category_widget.dart';
import 'widgets/edit_category_sheet.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoneyBloc, GetMoneyUsage>(builder: (context, state) {
      MoneyUsage moneyUsage = state.moneyUsage!;
      List<Category> categories = moneyUsage.categories;

      return Scaffold(
        appBar: AppBar(
          title: const Text('الافئات'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.bottomSheet(
              EditCategorySheet(
                onStartCounter: (category) {
                  Get.back();
                  moneyUsage.categories.add(category);
                  BlocProvider.of<MoneyBloc>(context)
                      .add(SaveMoneyUsage(moneyUsage));
                },
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return CategoryWidget(
              category: categories[index],
              onTap: () {
                Get.bottomSheet(EditCategorySheet(
                  onDelete: () {
                    Get.back();

                    moneyUsage.categories.removeAt(index);
                    BlocProvider.of<MoneyBloc>(context)
                        .add(SaveMoneyUsage(moneyUsage));
                  },
                  category: categories[index],
                  onStartCounter: (category) {
                    Get.back();

                    moneyUsage.categories[index] = category;
                    BlocProvider.of<MoneyBloc>(context)
                        .add(SaveMoneyUsage(moneyUsage));
                  },
                ));
              },
            );
          },
        ),
      );
    });
  }
}
