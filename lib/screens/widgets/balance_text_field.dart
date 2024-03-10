import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_tools_bag/my_tools_bag.dart';

class BalanceTextField extends StatelessWidget {
  final bool isEditMode;
  final String fieldName;
  final TextEditingController controller;
  final void Function()? onEdit;
  const BalanceTextField({
    super.key,
    required this.isEditMode,
    this.onEdit,
    required this.fieldName,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isEditMode,
      replacement: ListTile(
        title: Text(controller.text),
        trailing: IconButton(
          onPressed: onEdit,
          icon: const Icon(Icons.edit),
        ),
      ),
      child: BeautyTextField(
        fieldName: fieldName,
        controller: controller,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
