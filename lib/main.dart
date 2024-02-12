import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/used_money_chart_screen.dart';

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
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const UsedMoneyChartScreen(),
    );
  }
}
