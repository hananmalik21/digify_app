import 'package:digify_app/core/extensions/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatCard extends StatelessWidget {
  final String icon;
  final String value;
  final String label;
  final Color accentColor;
  final double highlight; // 0..1

  const StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.accentColor,
    required this.highlight,
  });

  @override
  Widget build(BuildContext context) {
    // Border + glow intensity based on [highlight]
    final borderWidth = 1.0 + 2.0 * highlight;
    final borderColor = accentColor.withOpacity(0.15 + 0.45 * highlight);
    final backgroundColor =
        Color.lerp(
          const Color(0xFF0D133A),
          accentColor.withOpacity(0.10),
          highlight * 0.7,
        ) ??
        const Color(0xFF0D133A);
    final shadowColor = accentColor.withOpacity(
      0.18 + 0.32 * highlight,
    ); // glow

    return Container(
      width: 220,
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 18 + 10 * highlight,
            spreadRadius: 2 + 2 * highlight,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(icon),
          const SizedBox(height: 12),
          Text(value, style: context.text24Bold),
          const SizedBox(height: 6),
          Text(label, style: context.text16Medium, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
