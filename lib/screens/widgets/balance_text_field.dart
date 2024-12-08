import 'package:flutter/material.dart';

import 'beauty_text_field.dart';

class BalanceTextField extends StatelessWidget {
  final bool isEditMode;
  final String currency;
  final TextEditingController controller;
  final void Function()? onEdit;
  const BalanceTextField({
    super.key,
    required this.isEditMode,
    this.onEdit,
    required this.currency,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isEditMode,
      replacement: ListTile(
        title: Row(
          children: [
            Text(
              controller.text,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 5),
            Text(currency),
          ],
        ),
        trailing: IconButton(
          onPressed: onEdit,
          icon: const Icon(Icons.edit),
        ),
      ),
      child: BeautyTextField(
        fieldName: currency,
        controller: controller,
        // inputFormatters: [FilteringTextInputFormatter.allow(Pattern)],
        textInputType: TextInputType.number,
        textDirection: TextDirection.ltr,
        suffixIcon: IconButton(
          onPressed: onEdit,
          icon: const Icon(Icons.done),
        ),
      ),
    );
  }
}
