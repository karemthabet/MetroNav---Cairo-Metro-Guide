import 'package:flutter/material.dart';
import 'package:metro_app/core/utils/colors/app_colors.dart';
import 'package:metro_app/core/utils/constants/app_constants.dart';

class CustomDropDown extends StatelessWidget {
  final String label;
  final String? value;
  final void Function(String?)? onChanged;

  const CustomDropDown({
    super.key,
    required this.label,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ شيل التكرارات لتجنب Assertion خط الدروبدوان
    final stations = AppConstants.allStationsUnique();

    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.text),
        filled: true,
        fillColor: AppColors.card,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.text, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary, width: 1),
        ),
      ),
      dropdownColor: AppColors.card,
      style: const TextStyle(color: AppColors.text),
      iconEnabledColor: AppColors.text,
      items:
          stations
              .map((s) => DropdownMenuItem(value: s, child: Text(s)))
              .toList(),
      onChanged: onChanged,
    );
  }
}
