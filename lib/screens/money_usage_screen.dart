import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:money_manager/bloc/money_updates_bloc.dart';
import 'package:money_manager/models/money_usage.dart';
import 'package:money_manager/screens/update_usage_screen.dart';
import 'package:my_tools_bag/tools/date_formatter.dart';

class MoneyUsageScreen extends StatelessWidget {
  const MoneyUsageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MoneyBloc>(context).add(
        GetMoneyUsage(MoneyUsage(lastUpdate: DateTime.now(), expenses: [])));
    return BlocBuilder<MoneyBloc, GetMoneyUsage>(builder: (context, state) {
      log(state.moneyUsage.expenses.length.toString());
      return Scaffold(
        appBar: AppBar(title: const Text('تتبع المشتريات')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => UpdateUsageScreen(
                  moneyUpdates: state.moneyUsage,
                ));
          },
          child: const Icon(Icons.update),
        ),
        body: ListView.builder(
          itemCount: state.moneyUsage.expenses.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(state.moneyUsage.expenses[index].purchase),
                subtitle: Row(
                  children: [
                    Text(
                      '${state.moneyUsage.expenses[index].usedMoney} جنيه',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(DateFormatter.formatDateAR(
                      state.moneyUsage.expenses[index].date,
                      isFull: false,
                    )),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
