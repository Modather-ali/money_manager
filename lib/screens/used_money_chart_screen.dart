import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:money_manager/bloc/money_updates_bloc.dart';
import 'package:money_manager/screens/widgets/tracker_chart.dart';

import '../models/money_updates.dart';
import 'update_usage_screen.dart';

class UsedMoneyChartScreen extends StatelessWidget {
  const UsedMoneyChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MoneyBloc>(context).add(
        GetMoneyUpdates(MoneyUpdates(lastUpdate: DateTime.now(), updates: [])));
    return BlocBuilder<MoneyBloc, GetMoneyUpdates>(builder: (context, state) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => UpdateUsageScreen(
                  moneyUpdates: state.moneyUpdates,
                ));
          },
          child: const Icon(Icons.update),
        ),
        body: const TrackerChart(
          scoreOfMonth: [], //state.moneyUpdates.updates,
          target: 100,
        ),
      );
    });
  }
}
