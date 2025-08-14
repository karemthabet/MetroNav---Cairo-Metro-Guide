import 'package:flutter/material.dart';
import 'package:metro_app/core/utils/colors/app_colors.dart';
import 'package:metro_app/features/planning/data/station_coordinates.dart';

class CustomDropDown extends StatelessWidget {
  final String label;                // عنوان الحقل
  final String? value;               // القيمة المختارة حاليًا
  final void Function(String?)? onChanged; // حدث عند تغيير الاختيار

  const CustomDropDown({
    super.key,
    required this.label,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // 📌 جلب أسماء المحطات بدون تكرار
    final stationsNames = stationsCoordinates
        .map((station) => station.name)
        .toSet()
        .toList();

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
      items: stationsNames
          .map((s) => DropdownMenuItem(
                value: s,
                child: Text(s, textAlign: TextAlign.right),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }
}
