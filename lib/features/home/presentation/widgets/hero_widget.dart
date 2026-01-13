import 'dart:async' show Timer;

import 'package:digify_app/core/extensions/colors.dart';
import 'package:digify_app/core/extensions/textstyles.dart';
import 'package:digify_app/features/common_widgets/hover_affect_widget.dart';
import 'package:digify_app/features/home/presentation/widgets/stats_card.dart' show StatCard;
import 'package:digify_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  final String _fullDescription =
      "Leading technology partner specializing in custom web development, innovative software solutions, mobile applications, and strategic digital marketing services across Pakistan, Middle East, and USA.";

  String _visibleText = "";
  int _charIndex = 0;
  Timer? _typingTimer;

  // Location chip animation (up/down)
  late AnimationController _locationController;
  late Animation<double> _locationFloat;

  // Stats highlight animation (one by one)
  late AnimationController _statsController;

  @override
  void initState() {
    super.initState();

    // 🔹 Smooth up/down animation only (infinite) for location row
    _locationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _locationFloat = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _locationController, curve: Curves.easeInOut),
    );

    // 🔹 One-by-one spotlight for stats (1 → 2 → 3 → 4 → loop)
    _statsController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6), // full cycle across 4 cards
    )..repeat();

    _startTyping();
  }

  void _startTyping() {
    const typingSpeed = Duration(milliseconds: 35);

    _typingTimer = Timer.periodic(typingSpeed, (timer) {
      if (_charIndex < _fullDescription.length) {
        setState(() {
          _visibleText += _fullDescription[_charIndex];
          _charIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _locationController.dispose();
    _statsController.dispose();
    super.dispose();
  }

  /// 0..1 progress of "highlight" for card [index] (0..3)
  double _cardHighlightProgress(int index) {
    final t = _statsController.value; // 0..1
    const segment = 1.0 / 4.0; // four cards
    final start = index * segment;
    final end = start + segment;

    if (t < start || t > end) return 0.0;

    final localT = (t - start) / segment; // 0..1 inside its window
    // first half: forward, second half: back → 0 → 1 → 0
    final phase = localT < 0.5 ? (localT / 0.5) : ((1.0 - localT) / 0.5);
    return Curves.easeInOut.transform(phase);
  }

  Widget _buildAnimatedStat({
    required int index,
    required String icon,
    required String value,
    required String label,
    required Color accentColor,
  }) {
    return HoverAffectWidget(
      child: AnimatedBuilder(
        animation: _statsController,
        builder: (context, _) {
          final p = _cardHighlightProgress(index); // 0..1
          final scale = 1.0 + 0.08 * p; // comes forward a bit
          final dy = -10 * p; // slight lift
      
          return Transform.translate(
            offset: Offset(0, dy),
            child: Transform.scale(
              scale: scale,
              child: StatCard(
                icon: icon,
                value: value,
                label: label,
                accentColor: accentColor,
                highlight: p, // used for border / glow
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.images.homeBg.path),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          20.verticalSpace,

          // 🔥 smooth up/down movement on location pill
          AnimatedBuilder(
            animation: _locationFloat,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _locationFloat.value),
                child: child,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.images.locationIcon),
                8.horizontalSpace,
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF112A39),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: context.greenTextColor),
                  ),
                  child: Text(
                    "Pakistan  ·  Middle East  ·  USA",
                    style: context.text16Medium.copyWith(
                      color: context.greenTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          24.verticalSpace,

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Transforming Ideas Into ",
                style: context.text18Regular,
                textAlign: TextAlign.center,
              ),
              ShaderMask(
                shaderCallback: (bounds) =>
                    const LinearGradient(
                      colors: [Color(0xFF4983FF), Color(0xFF9E6AFF)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                child: Text("DIGIFYAPPS", style: context.text18Regular),
              ),
            ],
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: ScreenUtil().screenWidth * 0.6,
            child: Text(
              _visibleText.isEmpty ? " " : _visibleText,
              textAlign: TextAlign.center,
              style: context.text20Regular,
            ),
          ),

          40.verticalSpace,

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IntrinsicWidth(
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3E5BFF),
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 22,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () {},
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("View Our Work",
                            style: TextStyle(fontSize: 16, color: Colors.white)),
                        SizedBox(width: 6),
                        Icon(Icons.arrow_forward, size: 18, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 15),

              IntrinsicWidth(
                child: SizedBox(
                  height: 52,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xff252F4C),
                      side: const BorderSide(color: Color(0xff373737)),
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 22,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Contact Us",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 50),

          // ⭐ Stats: one-by-one forward/back + border glow
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 25,
            runSpacing: 20,
            children: [
              _buildAnimatedStat(
                index: 0,
                icon: Assets.images.completionIcon,
                value: "50+",
                label: "Projects Completed",
                accentColor: const Color(0xFF2F7BFF), // blue
              ),
              _buildAnimatedStat(
                index: 1,
                icon: Assets.images.happyClientsIcon,
                value: "40+",
                label: "Happy Clients",
                accentColor: const Color(0xFF00C272), // green
              ),
              _buildAnimatedStat(
                index: 2,
                icon: Assets.images.yearsExperienceIcon,
                value: "4+",
                label: "Years Experience",
                accentColor: const Color(0xFFB25DFF), // purple
              ),
              _buildAnimatedStat(
                index: 3,
                icon: Assets.images.clientSatisfactionIcon,
                value: "100%",
                label: "Client Satisfaction",
                accentColor: const Color(0xFFFF7A2F), // orange
              ),
            ],
          ),
        ],
      ),
    );
  }
}