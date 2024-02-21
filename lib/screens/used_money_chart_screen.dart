import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:money_manager/bloc/money_updates_bloc.dart';

import '../models/money_usage.dart';
import 'update_usage_screen.dart';

class UsedMoneyChartScreen extends StatelessWidget {
  const UsedMoneyChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MoneyBloc>(context).add(
        GetMoneyUpdates(MoneyUsage(lastUpdate: DateTime.now(), expenses: [])));
    return BlocBuilder<MoneyBloc, GetMoneyUpdates>(builder: (context, state) {
      log(state.moneyUsage.expenses.length.toString());
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => UpdateUsageScreen(
                  moneyUpdates: state.moneyUsage,
                ));
          },
          child: const Icon(Icons.update),
        ),
      );
    });
  }
}
