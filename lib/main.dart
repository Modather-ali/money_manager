import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:money_manager/sign_in_screen.dart';
import 'package:my_tools_bag/tools/logger_utils.dart';

import 'bloc/money_updates_bloc.dart';
import 'screens/used_money_chart_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    Logger.print(user == null);
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoneyBloc>(
          create: (BuildContext context) => MoneyBloc(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Money Manager',
        theme: ThemeData(useMaterial3: true),
        home:
            user == null ? const SignInScreen() : const UsedMoneyChartScreen(),
      ),
    );
  }
}
