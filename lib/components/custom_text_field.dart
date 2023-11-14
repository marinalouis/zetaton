import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, this.controller, this.label, this.obscure});
  final TextEditingController? controller;
  final String? label;
  final bool? obscure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure ?? false,
      decoration: InputDecoration(labelText: label),
    );
  }
}
