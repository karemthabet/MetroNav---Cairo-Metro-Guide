import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddressTextField extends StatelessWidget {
  AddressTextField({
    super.key,
    required this.textController,
    required this.label,
  });

  TextEditingController textController = TextEditingController();
  String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
        label: Text(label, style: TextStyle(color: Colors.white)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1), // اللون العادي
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
    );
  }
}
