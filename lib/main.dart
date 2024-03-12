import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'bloc/money_updates_bloc.dart';
import 'screens/money_usage_screen.dart';
import 'screens/sign_in_screen.dart';
import 'tools/logger_utils.dart';

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
        theme: FlexThemeData.light(
            useMaterial3: true, scheme: FlexScheme.gold, fontFamily: 'Rubik'),
        locale: const Locale('ar'),
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const [Locale('ar')],
        home: user == null ? const SignInScreen() : const MoneyUsageScreen(),
      ),
    );
  }
}
