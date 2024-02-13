import 'package:flutter/material.dart';

class MoneyTextFormField extends StatelessWidget {
   final TextEditingController? controller;
  const MoneyTextFormField({
    super.key, this.controller
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(),
          // prefixIcon: Icon(
          //   Icons.attach_money,
          //   color: color,
          // ),
        ),
        // inputFormatters: const <TextInputFormatter>[
        // FilteringTextInputFormatter.digitsOnly
        // ],
        validator: (text) {
          final isNumber = num.tryParse(text!);
          if (text.isEmpty) {
            return "This value is empty";
          } else if (isNumber == null) {
            return '"$text" is not a valid number';
          }
          return null;
        },
        keyboardType: TextInputType.number,
      ),
    );
  }
}
