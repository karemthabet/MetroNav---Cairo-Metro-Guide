import 'package:flutter/material.dart';
import 'package:metro_app/core/utils/colors/app_colors.dart';

class AddressTextField extends StatelessWidget {
  const AddressTextField({
    super.key,
    required this.textController,
    required this.label,
  });

  final TextEditingController textController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      style: const TextStyle(color: AppColors.text),
      decoration: InputDecoration(
        label: Text(label, style: const TextStyle(color: AppColors.text)),
        filled: true,
        fillColor: AppColors.card,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.text, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primary, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
