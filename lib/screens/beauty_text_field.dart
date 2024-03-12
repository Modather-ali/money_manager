import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BeautyTextField extends StatelessWidget {
  const BeautyTextField({
    Key? key,
    required this.fieldName,
    this.textInputType,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.isNumber = false,
    this.controller,
    this.textDirection,
    this.maxLines = 1,
    this.inputFormatters,
    this.borderColor,
  }) : super(key: key);

  final String fieldName;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final TextDirection? textDirection;
  final bool? enabled;
  final bool readOnly;
  final bool isNumber;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextFormField(
        enabled: enabled,
        readOnly: readOnly,
        onChanged: onChanged,
        controller: controller,
        validator: validator,
        maxLines: maxLines,
        scrollPadding: const EdgeInsets.all(50),
        keyboardType: isNumber ? TextInputType.phone : textInputType,
        textInputAction: textInputAction,
        textDirection: textDirection,
        inputFormatters: isNumber
            ? [FilteringTextInputFormatter.digitsOnly]
            : inputFormatters,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color:
                  borderColor ?? Theme.of(context).colorScheme.inversePrimary,
              width: 2.0,
            ),
          ),
          border: const OutlineInputBorder(borderSide: BorderSide(width: 2.0)),
          labelText: fieldName.tr,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
        obscureText: obscureText,
      ),
    );
  }
}
