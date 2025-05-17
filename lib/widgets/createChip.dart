import 'package:flutter/material.dart';

Widget createChip(IconData icon, String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    decoration: BoxDecoration(
        color: const Color(0xFFE6E5E5),
        borderRadius: BorderRadius.circular(4)
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 10, color: Colors.grey[800]),
        const SizedBox(width: 2),
        Text(text, style: const TextStyle(fontSize: 11)
        ),
      ],
    ),
  );
}