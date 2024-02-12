import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_manager/screens/tracker_chart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Money Manager',
      theme: ThemeData(),
      home: const UsedMoneyChartScreen(),
    );
  }
}

class UsedMoneyChartScreen extends StatelessWidget {
  const UsedMoneyChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TrackerChart(
        scoreOfMonth: [100, 150, 90, 100, 160, 500, 25, 50, 400],
        target: 0,
      ),
    );
  }
}
