import 'package:digify_app/core/extensions/colors.dart';
import 'package:digify_app/core/extensions/textstyles.dart';
import 'package:digify_app/core/utils/utils.dart';
import 'package:digify_app/features/common_widgets/hover_affect_widget.dart';
import 'package:digify_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class PortfoliosView extends StatelessWidget {
  const PortfoliosView({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      color: const Color(0xFFF1F5FF),
      padding: EdgeInsets.symmetric(vertical:60,horizontal: Utils.isMobile(context)?50:102),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // pill
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE1EAFF),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "Explore",
                  style: context.text14Medium.copyWith(
                    color: const Color(0xFF165DFC),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                "Our Portfolio",
                style: context.text24SemiBold.copyWith(
                  fontSize: 28,
                  color: context.blackColor,
                ),
              ),
              const SizedBox(height: 10),

              Text(
                "Explore our successful projects across Pakistan,\nMiddle East, and USA",
                textAlign: TextAlign.center,
                style: context.text16Regular.copyWith(
                  color: context.blackColor.withOpacity(0.7),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),

              LayoutBuilder(
                builder: (context, constraints) {
                  int col = 3;
                  if (constraints.maxWidth < 1000) col = 2;
                  if (constraints.maxWidth < 650) col = 1;

                  const spacing = 40.0;
                  final cardWidth =
                      (constraints.maxWidth - (col - 1) * spacing) / col;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    alignment: WrapAlignment.center,
                    children: _portfolioItems.map((item) {
                      return SizedBox(
                        width: cardWidth,
                        child: PortfolioCard(
                          image: item['image'] as String,
                          title: item['title'] as String,
                          subtitle: item['subtitle'] as String,
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// put this OUTSIDE the TestimonialView class ⬇️⬇️⬇️
class PortfolioCard extends StatefulWidget {
  final String image;
  final String title;
  final String subtitle;

  const PortfolioCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  State<PortfolioCard> createState() => _PortfolioCardState();
}

class _PortfolioCardState extends State<PortfolioCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return HoverAffectWidget(
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),

        child: Container(
          width: 360,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),

                child: SizedBox(
                  height: Utils.isMobile(context) ? 200 : 392,
                  child: Stack(
                    children: [
                      AnimatedScale(
                        scale: _isHovered ? 1.08 : 1.0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,

                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(28),
                            bottomRight: Radius.circular(28),
                          ),
                          child: Image.asset(
                            widget.image,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 4),
                child: Text(
                  widget.title,
                  style: context.text24Bold.copyWith(color: context.blackColor),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  widget.subtitle,
                  style: context.text14Regular.copyWith(color: context.blackColor),
                ),
              ),

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 20),
                child: Row(
                  children: [
                    Text(
                      "Learn More",
                      style: context.text16Regular.copyWith(
                        color: const Color(0xff165DFC),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.north_east,
                      size: 16,
                      color: Color(0xFF165DFC),
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

// sample data
final List<Map<String, String>> _portfolioItems = [
  {
    "image": Assets.images.ahuse.path,
    "title": "Ahuse",
    "subtitle":
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius enim in eros.",
  },
  {
    "image": Assets.images.appDashboard.path,
    "title": "App Dashboard",
    "subtitle":
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius enim in eros.",
  },
  {
    "image": Assets.images.easyRent.path,
    "title": "Easy Rent",
    "subtitle":
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius enim in eros.",
  },
  // {
  //   "image": Assets.images.port1.path,
  //   "title": "Ahuse",
  //   "subtitle":
  //   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius enim in eros.",
  // },
  // {
  //   "image": Assets.images.port2.path,
  //   "title": "App Dashboard",
  //   "subtitle":
  //   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius enim in eros.",
  // },
  // {
  //   "image": Assets.images.port3.path,
  //   "title": "Easy Rent",
  //   "subtitle":
  //   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius enim in eros.",
  // },
];
