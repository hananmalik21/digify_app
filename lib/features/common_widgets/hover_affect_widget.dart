
import 'package:flutter/material.dart';

class HoverAffectWidget extends StatefulWidget {
  final Widget child;
  final double hoverScale;
  final Duration duration;
  final bool addShadow;
  final BorderRadius? borderRadius;

  const HoverAffectWidget({
    super.key,
    required this.child,
    this.hoverScale = 1.04,
    this.duration = const Duration(milliseconds: 220),
    this.addShadow = true,
    this.borderRadius,
  });

  @override
  State<HoverAffectWidget> createState() => _HoverAffectWidgetState();
}

class _HoverAffectWidgetState extends State<HoverAffectWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: widget.duration,
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..scale(_isHovered ? widget.hoverScale : 1.0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          boxShadow: widget.addShadow && _isHovered
              ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ]
              : const [],
        ),
        child: widget.child,
      ),
    );
  }
}