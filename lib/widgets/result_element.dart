
import 'package:flutter/material.dart';

class ResultElement extends StatelessWidget {
  ResultElement({
    super.key,
    required this.text,
    required this.result,
    this.details = '',
  });
  final String text;
  final String result;
  final String? details;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFFBCBCBC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text('${text + result}'),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(details!)],
            ),
          ),
        ],
      ),
    );
  }
}
