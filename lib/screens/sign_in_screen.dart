import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../firebase/firebase.dart';
import 'money_usage_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'تسجيل الدخول',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: 15,
            width: Get.width,
          ),
          ElevatedButton(
            onPressed: () async {
              await FireAuth.signInWithGoogle();
              // if (result) {
              if (!context.mounted) return;
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const MoneyUsageScreen(),
              ));
              // }
            },
            child: Image.asset(
              'assets/images/google_icon.png',
              height: 30,
            ),
          ),
        ],
      ),
    );
  }
}
