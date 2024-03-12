import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../bloc/money_updates_bloc.dart';
import '../models/money_usage.dart';
import 'balance_screen.dart';
import 'update_usage_screen.dart';
import 'widgets/loading_view.dart';
import 'widgets/transaction_widget.dart';

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
          reverse: true,
          itemBuilder: (context, index) {
            return TransactionWidget(
                transaction: moneyUsage.transactions[index]);
          },
        ),
      );
    });
  }
}
