import 'package:flutter/material.dart';

import '../service/authentication.dart';

class Registration extends StatelessWidget {
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: InkWell(
          onTap: () {
            Authentication().signInWithGoogle();
          },
          child: Container(
            width: 150,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(4, 4),
                  spreadRadius: 1,
                  blurRadius: 15,
                ),
                BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(-4, -4),
                  spreadRadius: 1,
                  blurRadius: 15,
                ),
              ],
              image: const DecorationImage(
                image: AssetImage("assets/images/google_icon.png"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
