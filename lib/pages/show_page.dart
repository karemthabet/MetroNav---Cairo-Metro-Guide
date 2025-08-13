import 'package:flutter/material.dart';
import 'package:metro_app/widgets/result_element.dart';

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
