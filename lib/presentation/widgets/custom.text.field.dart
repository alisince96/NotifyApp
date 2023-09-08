import 'package:flutter/material.dart';
import 'package:p_notify/app/constants/app.colors.dart';
import 'package:p_notify/app/constants/app.fonts.dart';

class CustomTextField {
  static customTextField(
      {required TextEditingController textEditingController,
      required String hintText,
      bool? obsecure = false,
      String? Function(String?)? validator,
      Function(String)? onChanged}) {
    return TextFormField(
      obscureText: obsecure!,
      keyboardType: TextInputType.visiblePassword,
      style: const TextStyle(
        color: Colors.black,
        fontFamily: AppFonts.contax,
      ),
      onChanged: onChanged,
      controller: textEditingController,
      validator: validator,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.blueZodiac,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(color: AppColors.rawSienna),
        ),
      ),
    );
  }
}