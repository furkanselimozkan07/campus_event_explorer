import 'package:flutter/material.dart';

String formatEventDate(DateTime value) {
  String twoDigits(int number) => number.toString().padLeft(2, '0');
  return '${twoDigits(value.day)}.${twoDigits(value.month)}.${value.year} '
      '• ${twoDigits(value.hour)}:${twoDigits(value.minute)}';
}

Color eventCategoryColor(String category) {
  switch (category) {
    case 'Technology':
      return const Color(0xFF2457B2);
    case 'Arts':
      return const Color(0xFF9850A4);
    case 'Sports':
      return const Color(0xFF168272);
    default:
      return Colors.grey;
  }
}
