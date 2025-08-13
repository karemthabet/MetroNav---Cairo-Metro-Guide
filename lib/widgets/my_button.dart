import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
   MyButton({
    super.key,
    required this.text,
    required this.widthButton,
    required this.color,
    required this.onTap,
  });

  final String text;
  final Color color;
  final double widthButton;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * widthButton,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
        ),
        padding: EdgeInsets.all(8),
        child: Center(
          child: Text(text, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
