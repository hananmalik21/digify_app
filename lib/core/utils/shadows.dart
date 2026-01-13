import 'package:flutter/material.dart';

class MootShadows {
  static List<BoxShadow> subtle = [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      offset: const Offset(0, 2),
      blurRadius: 6,
    ),
  ];

  static List<BoxShadow> neumorphic = [
    BoxShadow(
      color: Colors.white.withOpacity(1.0),
      offset: const Offset(-5, -5),
      blurRadius: 10,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.12),
      offset: const Offset(6, 6),
      blurRadius: 16,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.025),
      offset: const Offset(0, 2),
      blurRadius: 6,
    ),
  ];

  static List<BoxShadow> strong = [
    BoxShadow(
      color: Colors.black.withOpacity(0.18),
      offset: const Offset(0, 4),
      blurRadius: 12,
    ),
  ];
}
