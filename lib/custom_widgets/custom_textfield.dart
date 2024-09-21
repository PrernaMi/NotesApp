import 'package:flutter/material.dart';

class CustomTextField {

  static TextField mTextField(
      {required TextEditingController controller,
      required String hint,
        required String label,
      required double borderRadius,
      required Icon prefixIcon,
      TextInputType type = TextInputType.text,
        bool showText = false
      }) {
    return TextField(
      controller: controller,
      keyboardType: type,
      obscureText: showText,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        )
      ),
    );
  }
}
