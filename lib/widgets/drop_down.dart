import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {
  DropDown({
    super.key,
    required this.label,
    required this.cairoMetroLine1,
    required this.cairoMetroLine2,
    required this.cairoMetroLine3,
  });

  String label;
  List<String> cairoMetroLine1;
  List<String> cairoMetroLine2;
  List<String> cairoMetroLine3;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // هنا العرض على قد الشاشة
      child: DropdownMenu(
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 1,
            ), // اللون العادي
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1,
            ), // لون عند التركيز
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
        ),
        width: double.infinity,
        label: Text(label, style: TextStyle(color: Colors.white)),
        textStyle: TextStyle(color: Colors.white),
        enableSearch: true,
        enableFilter: true,
        requestFocusOnTap: true,
        dropdownMenuEntries: [
          for (int i = 0; i < cairoMetroLine1.length; i++)
            DropdownMenuEntry(
              value: cairoMetroLine1[i],
              label: cairoMetroLine1[i],
            ),
          for (int i = 0; i < cairoMetroLine2.length; i++)
            DropdownMenuEntry(
              value: cairoMetroLine2[i],
              label: cairoMetroLine2[i],
            ),
          for (int i = 0; i < cairoMetroLine3.length; i++)
            DropdownMenuEntry(
              value: cairoMetroLine3[i],
              label: cairoMetroLine3[i],
            ),
        ],
      ),
    );
  }
}
