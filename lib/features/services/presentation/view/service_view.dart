import 'package:digify_app/core/extensions/colors.dart';
import 'package:digify_app/core/extensions/textstyles.dart';
import 'package:digify_app/features/services/presentation/widgets/service_card.dart';
import 'package:digify_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final bool isMobile = width < 750;

    return Container(
      width: double.infinity,
      color: const Color(0xFFF0F6FF), // light blue bg
      padding:  EdgeInsets.symmetric(vertical: isMobile ? 30 :60, horizontal: isMobile ? 40: 102),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ⭐ Pill
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFDBEAFF),
                  borderRadius: BorderRadius.circular(30),
                ),
                child:  Text(
                  "Our Expertise",
                  style: context.text16SemiBold.copyWith(color: Color(0xff165DFC))
                ),
              ),

              24.verticalSpace,

               Text(
                "Comprehensive Digital Services",
                  style: context.text24SemiBold.copyWith(color: context.blackColor)

              ),

              24.verticalSpace,

               Text(
                "From concept to launch, we deliver end-to-end\nsolutions that drive growth",
                textAlign: TextAlign.center,
                  style: context.text16Regular.copyWith(color: context.blackColor)

              ),

              const SizedBox(height: 40),

              // ⭐ Responsive Grid (3 columns desktop, 2 tablet, 1 mobile)
              LayoutBuilder(
                builder: (context, constraints) {
                  int col = 3;
                  if (constraints.maxWidth < 900) col = 2;
                  if (constraints.maxWidth < 600) col = 1;

                  double cardWidth =
                      (constraints.maxWidth - (col - 1) * 20) / col;

                  return Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: _services.map((service) {
                      return SizedBox(
                        width: cardWidth,
                        child: ServiceCard(
                          image: service['image'],
                          icon: service['icon'],
                          title: service['title'],
                          subtitle: service['subtitle'],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),

              const SizedBox(height: 40),

              // ⭐ CTA Button
        IntrinsicWidth(
          child: SizedBox(
            // height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3E5BFF),
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,   // reduced so text fits on mobile
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),

              onPressed: () => context.go('/services'),
              child:
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "Explore All Services",
                      overflow: TextOverflow.ellipsis,
                      style: context.text16Medium,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              )


              // const Text(
              //   "Explore All Services ",
              //   style: TextStyle(fontSize: 16, color: Colors.white),
              // ),
            ),
          ),
        ),

            ],
          ),
        ),
      ),
    );
  }
}

// ⭐ Dummy service list (replace icons/images with your assets)
final List<Map<String, dynamic>> _services = [
  // {
  //   "image": Assets.images.webDev.path,
  //   "icon": Icons.code,
  //   "title": "Web Development",
  //   "subtitle": "Custom websites and web applications",
  // },
  {
    "image": Assets.images.mobDev.path,
    "icon": Assets.images.mobDevIcon,
    "title": "Mobile App Development",
    "subtitle": "iOS and Android applications",
  },
  {
    "image": Assets.images.digitalMarketing.path,
    "icon": Assets.images.digitalMarketingIcon,
    "title": "Digital Marketing",
    "subtitle": "SEO, social media & content strategy",
  },
  {
    "image": Assets.images.webDev.path,
    "icon": Assets.images.webDevIcon,
    "title": "Web Development",
    "subtitle": "Custom websites and web applications",
  },
  {
    "image": Assets.images.uiUx.path,
    "icon": Assets.images.uiUxIcon,
    "title": "UI/UX Design",
    "subtitle": "Beautiful user experiences",
  },
  {
    "image": Assets.images.cloudFunction.path,
    "icon": Assets.images.cloudSolutionIcon,
    "title": "Cloud Solutions",
    "subtitle": "Scalable cloud infrastructure",
  },
];

