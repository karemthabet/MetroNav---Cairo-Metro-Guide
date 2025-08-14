 import 'package:flutter/material.dart';

Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Tajawal',
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
              fontFamily: 'Tajawal',
            ),
          ),
        ],
      ),
    );
  }