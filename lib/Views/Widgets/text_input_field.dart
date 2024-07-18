import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_tutorial/constants.dart';

import '../../Controllers/theme_controller.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isObscure;
  final IconData icon;

  const TextInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.isObscure = false,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDarkMode = Get.find<ThemeController>().isDarkMode.value;
      return TextField(
        controller: controller,
        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black), // Text color based on theme mode
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(
            icon,
            color: isDarkMode ? Colors.white : Colors.black, // Icon color based on theme mode
          ),
          labelStyle: TextStyle(
            fontSize: 20,
            color: isDarkMode ? Colors.white : Colors.black, // Label text color based on theme mode
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: isDarkMode ? Colors.white : Colors.black, // Border color based on theme mode
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: isDarkMode ? Colors.white : Colors.black, // Border color based on theme mode
            ),
          ),
        ),
        obscureText: isObscure,
      );
    });
  }
}
