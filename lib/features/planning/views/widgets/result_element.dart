import 'package:flutter/material.dart';
import 'package:metro_app/core/utils/colors/app_colors.dart';

class ResultElement extends StatelessWidget {
  final String text;
  final String result;
  final String? details;

  const ResultElement({
    super.key,
    required this.text,
    required this.result,
    this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '$text $result',
              style: const TextStyle(
                color: AppColors.text,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (details != null) ...[
              const SizedBox(height: 6),
              Text(details!, style: const TextStyle(color: Colors.white70)),
            ],
          ],
        ),
      ),
    );
  }
}
