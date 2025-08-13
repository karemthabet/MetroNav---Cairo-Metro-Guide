import 'package:flutter/material.dart';

class ShowPage extends StatelessWidget {
  const ShowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF323232),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          spacing: 8,
          children: [
            const SizedBox(height: 5),
            ResultElement(text: "تيكيت : ", result: '10'),
            ResultElement(
              text: "عدد المحطات : ",
              result: '5',
              details: 'المرج,حلوان,زراعه,رمسيس,شبرا',
            ),
          ],
        ),
      ),
    );
  }
}

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
