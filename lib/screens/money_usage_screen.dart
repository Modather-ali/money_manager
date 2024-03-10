import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:money_manager/bloc/money_updates_bloc.dart';
import 'package:money_manager/models/money_usage.dart';
import 'package:money_manager/screens/update_usage_screen.dart';
import 'package:my_tools_bag/tools/date_formatter.dart';

import 'balance_screen.dart';

class MoneyUsageScreen extends StatelessWidget {
  const MoneyUsageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MoneyBloc>(context).add(GetMoneyUsage(
        MoneyUsage(lastUpdate: DateTime.now(), transactions: [])));
    return BlocBuilder<MoneyBloc, GetMoneyUsage>(builder: (context, state) {
      if (state.moneyUsage == null) {
        return const LoadingView();
      }
      log(state.moneyUsage!.transactions.length.toString());
      MoneyUsage moneyUsage = state.moneyUsage!;
      return Scaffold(
        appBar: AppBar(
          title: const Text('تتبع المشتريات'),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => BalanceScreen(moneyUsage: moneyUsage));
                },
                icon: const Icon(Icons.account_balance_wallet_rounded)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => UpdateUsageScreen(
                  moneyUsage: moneyUsage,
                ));
          },
          child: const Icon(Icons.addchart),
        ),
        body: ListView.builder(
          itemCount: moneyUsage.transactions.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(moneyUsage.transactions[index].purchase),
                subtitle: Row(
                  children: [
                    Text(
                      '${moneyUsage.transactions[index].usedMoney} جنيه',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(DateFormatter.formatDateAR(
                      moneyUsage.transactions[index].date,
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

class LoadingView extends StatelessWidget {
  const LoadingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: const CircularProgressIndicator());
  }
}
