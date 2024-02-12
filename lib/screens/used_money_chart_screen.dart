import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_manager/screens/widgets/tracker_chart.dart';

import 'update_usage_screen.dart';

class UsedMoneyChartScreen extends StatelessWidget {
  const UsedMoneyChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const UpdateUsageScreen());
        },
        child: const Icon(Icons.update),
      ),
      body: const TrackerChart(
        scoreOfMonth: [100, 150, 90, 100, 160, 500, 25, 50, 400],
        target: 100,
      ),
    );
  }
}
