import 'package:digify_app/core/extensions/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServiceCard extends StatefulWidget {
  final String image;
  final String icon;
  final String title;
  final String subtitle;

  const ServiceCard({
    super.key,
    required this.image,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        height: 240,
        transform: Matrix4.identity()..scale(_isHovered ? 1.04 : 1.0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: _isHovered
              ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ]
              : const [],
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // ⭐ Inner image zoom
              AnimatedScale(
                scale: _isHovered ? 1.12 : 1.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                child: Image.asset(
                  widget.image,
                  fit: BoxFit.cover,
                ),
              ),

              // ⭐ ALWAYS BLACK OVERLAY (60%)
              Container(
                color: Colors.black.withOpacity(0.60),
              ),

              // ⭐ Gradient on top
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.70),
                    ],
                  ),
                ),
              ),

              // ⭐ Text + Icon
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SvgPicture.asset(widget.icon),
                    ),

                    const Spacer(),

                    Text(widget.title, style: context.text24SemiBold),
                    const SizedBox(height: 4),
                    Text(widget.subtitle, style: context.text16Medium),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Text(
                          "Learn More",
                          style: context.text16Medium.copyWith(
                            color: const Color(0xff165DFC),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.arrow_forward,
                          color: Color(0xff165DFC),
                          size: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
