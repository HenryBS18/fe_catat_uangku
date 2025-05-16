import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String labelText;
  final IconData iconData;
  final TextEditingController controller;
  final bool obscureText;
  final String? errorText;

  const CustomTextForm({
    super.key,
    required this.labelText,  
    required this.iconData,
    required this.controller,
    this.obscureText = false,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
    decoration: InputDecoration(
  labelText: labelText,
  prefixIcon: Icon(iconData),
  errorText: errorText,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Colors.grey),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: Theme.of(context).primaryColor),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Colors.red),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Colors.red),
  ),
),
    );
  }
}

