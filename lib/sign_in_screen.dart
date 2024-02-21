import 'package:flutter/material.dart';
import 'package:money_manager/screens/used_money_chart_screen.dart';
import 'package:my_tools_bag/firebase/firebase.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await FireAuth.signInWithGoogle();
            // if (result) {
            if (!context.mounted) return;
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const UsedMoneyChartScreen(),
            ));
            // }
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(10),
          ),
          child: Image.asset(
            'assets/images/google_icon.png',
            height: 50,
          ),
        ),
      ),
    );
  }
}
