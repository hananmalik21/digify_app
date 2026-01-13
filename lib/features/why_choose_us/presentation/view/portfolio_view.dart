import 'package:digify_app/core/extensions/colors.dart';
import 'package:digify_app/core/extensions/textstyles.dart';
import 'package:digify_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WhyChooseUsSection extends StatelessWidget {
  const WhyChooseUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final bool isTablet = width < 1100;
    final bool isMobile = width < 800;

    return Center(
      child: Container(
        width: width,
        constraints: const BoxConstraints(maxWidth: 1200),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 40,
          vertical: isMobile ? 30 : 40,
        ),
        child: isMobile
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageGrid(context, isMobile),
            30.verticalSpace,
            _buildRightContent(context, isMobile),
          ],
        )
            : Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: isTablet ? 5 : 6,
              child: _buildImageGrid(context, isMobile),
            ),
            SizedBox(width: isTablet ? 24 : 40),
            Expanded(
              flex: 6,
              child: _buildRightContent(context, isMobile),
            ),
          ],
        ),
      ),
    );
  }

  // LEFT SIDE – IMAGE GRID + “Expertise” TILE
  Widget _buildImageGrid(BuildContext context, bool isMobile) {
    final double radius = 24;
    final double h = isMobile ? 180 : 220; // row height

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---------------- LEFT COLUMN (2 items) ----------------
        Expanded(
          flex: 5,
          child: Column(
            children: [
              _gridImage(Assets.images.port1.path, radius),
              16.verticalSpace,
              _gridImage(Assets.images.port3.path, radius),
            ],
          ),
        ),

        20.horizontalSpace,

        // ---------------- RIGHT COLUMN (3 items) ----------------
        Expanded(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _gridImage(Assets.images.port2.path, radius),
              16.verticalSpace,
              _gridImage(Assets.images.port4.path, radius),
              16.verticalSpace,
              _gridImage(Assets.images.port5.path, radius),
            ],
          ),
        ),
      ],
    );
  }

  Widget _gridImage(String path, double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.asset(
        path,
        fit: BoxFit.cover,
      ),
    );
  }


  // RIGHT SIDE – TEXT + “WHY CHOOSE US” CARDS
  Widget _buildRightContent(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment:
      isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.start,
      children: [
        // pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFE6F0FF),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            "Why Choose Us",
            style: context.text16SemiBold.copyWith(
              color: const Color(0xff165DFC),
            ),
          ),
        ),

        16.verticalSpace,

        Text(
          "Leading Pakistan's Digital\nTransformation",
          style: context.text24SemiBold.copyWith(
            color: context.blackColor,
            fontSize: isMobile ? 22 : 28,
            height: 1.2,
          ),
        ),

        12.verticalSpace,

        Text(
          "We combine technical expertise with creative innovation to "
              "deliver exceptional digital solutions that drive real business "
              "results across Pakistan, Middle East, and USA.",
          style: context.text16Regular.copyWith(
            color: context.blackColor.withOpacity(0.7),
            fontSize: isMobile ? 14 : 15,
            height: 1.5,
          ),
        ),

        24.verticalSpace,

        _FeatureCard(
          icon: Icons.verified_outlined,
          title: "Expert Team",
          subtitle: "Certified professionals with years of industry experience",
        ),
        14.verticalSpace,
        _FeatureCard(
          icon: Icons.check_circle_outline,
          title: "Proven Track Record",
          subtitle: "50+ successful projects delivered on time and on budget",
        ),
        14.verticalSpace,
        _FeatureCard(
          icon: Icons.support_agent_outlined,
          title: "24/7 Support",
          subtitle: "Dedicated support team ready to assist you anytime",
        ),
        14.verticalSpace,
        _FeatureCard(
          icon: Icons.location_on_outlined,
          title: "Local Expertise",
          subtitle:
          "Deep understanding of Pakistani market and business culture",
        ),
      ],
    );
  }
}

// ---------------- FEATURE CARD ----------------

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Row(
        children: [
          // icon with gradient bg
         SvgPicture.asset(Assets.images.portfolioIcon,height: 47,width: 47,),
          14.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: context.text16SemiBold.copyWith(
                    color: context.blackColor,
                  ),
                ),
                2.verticalSpace,
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.text16Regular.copyWith(
                    color: context.blackColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
