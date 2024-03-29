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

class MoneyUsageScreen extends StatefulWidget {
  const MoneyUsageScreen({super.key});

  @override
  State<MoneyUsageScreen> createState() => _MoneyUsageScreenState();
}

class _MoneyUsageScreenState extends State<MoneyUsageScreen> {
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
      List<Transaction> transactions = moneyUsage.transactions;

      return Scaffold(
        appBar: AppBar(
          title: const Text('الإدارة المالية'),
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
          itemCount: transactions.length,
          // reverse: true,
          // dragStartBehavior: DragStartBehavior.down,
          // controller: _scrollController,
          itemBuilder: (context, index) {
            return TransactionWidget(
              transaction: transactions[index],
              onTap: () {
                Get.to(() => UpdateUsageScreen(
                      moneyUsage: moneyUsage,
                      transactionIndex: index,
                    ));
              },
            );
          },
        ),
      );
    });
  }
}
