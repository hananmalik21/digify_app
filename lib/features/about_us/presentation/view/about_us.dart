import 'package:digify_app/core/extensions/colors.dart';
import 'package:digify_app/core/extensions/textstyles.dart';
import 'package:digify_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutUsSection extends StatelessWidget {
  const AboutUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Breakpoints
    final bool isMobile = width < 750;

    return Center(
      child: Container(

        width: width,
        constraints: const BoxConstraints(maxWidth: 1200),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 40 : 60,
          vertical: isMobile ? 30 : 40,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
        ),

        // COLUMN ON MOBILE / TABLET, ROW ON DESKTOP
        child: isMobile
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextSide(context, isMobile),
            30.verticalSpace,
            _buildImageSide(isMobile, width),
          ],
        )
            : Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // LEFT SIDE (TEXT)
            Expanded(flex: 6, child: _buildTextSide(context, isMobile)),

            SizedBox(width: width * 0.04),

            // RIGHT SIDE (IMAGE)
            Expanded(flex: 5, child: _buildImageSide(isMobile, width)),
          ],
        ),
      ),
    );
  }

  // ---------------- TEXT SIDE ----------------

  Widget _buildTextSide(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFE6F0FF),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            "About Us",
            style: context.text16Regular.copyWith(color: const Color(0xff165DFC)),
          ),
        ),

        20.verticalSpace,

        Text(
          "Innovating for a Digital Future",
          style: context.text24SemiBold.copyWith(
            color: context.blackColor,
            fontSize: isMobile ? 20 : 28,
          ),
        ),

        16.verticalSpace,

        Text(
          "We are a dynamic technology company with a proven track record of "
              "delivering innovative digital solutions across Pakistan, Middle East, "
              "and USA. Our team of expert developers, designers, and digital "
              "strategists work together to transform your vision into reality.\n\n"
              "With years of experience in the industry, we've helped businesses of "
              "all sizes establish their digital presence, streamline operations, and "
              "achieve their goals through technology. Our commitment to excellence "
              "and customer satisfaction has made us a trusted partner for companies "
              "throughout these regions.",
          style: context.text16Regular.copyWith(
            color: context.blackColor,
            fontSize: isMobile ? 14 : 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // ---------------- IMAGE SIDE ----------------

  Widget _buildImageSide(bool isMobile, double width) {
    // Dynamic responsive height
    double imageHeight;
    if (width > 1400) {
      imageHeight = 380;
    } else if (width > 1100) {
      imageHeight = 350;
    } else if (width > 900) {
      imageHeight = 320;
    } else if (width > 750) {
      imageHeight = 300;
    } else {
      imageHeight = 260;
    }

    return SizedBox(
      height: imageHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // BLUE BACKGROUND CARD
          Positioned(
            top: isMobile ? -20 : -35,
            left: isMobile ? -20 : -34,
            right: isMobile ? 20 : 40,
            bottom: isMobile ? 20 : 40,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF002A93),
                borderRadius: BorderRadius.circular(32),
              ),
            ),
          ),

          // FOREGROUND IMAGE
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Image.asset(
                Assets.images.aboutUs.path,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}





// import 'package:digify_app/core/extensions/colors.dart';
// import 'package:digify_app/core/extensions/textstyles.dart';
// import 'package:digify_app/gen/assets.gen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class AboutUsSection extends StatelessWidget {
//   const AboutUsSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//
//     return Center(
//       child: Container(
//         width: width,
//         constraints: const BoxConstraints(maxWidth: 1200),
//         padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(32),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             /// LEFT – Text
//             Expanded(
//               flex: 6,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // pill
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 24,
//                       vertical: 10,
//                     ),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFE6F0FF),
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     child: Text(
//                       "About Us",
//                       style: context.text16Regular.copyWith(
//                         color: Color(0xff165DFC),
//                       ),
//                     ),
//                   ),
//                   24.verticalSpace,
//                   Text(
//                     "Innovating for a Digital Future",
//                     style: context.text24SemiBold.copyWith(
//                       color: context.blackColor,
//                     ),
//                   ),
//                   20.verticalSpace,
//                   Text(
//                     "We are a dynamic technology company with a proven track record of "
//                     "delivering innovative digital solutions across Pakistan, Middle East, "
//                     "and USA. Our team of expert developers, designers, and digital "
//                     "strategists work together to transform your vision into reality.\n\n"
//                     "With years of experience in the industry, we've helped businesses of "
//                     "all sizes establish their digital presence, streamline operations, and "
//                     "achieve their goals through technology. Our commitment to excellence "
//                     "and customer satisfaction has made us a trusted partner for companies "
//                     "throughout these regions.",
//                     style: context.text16Regular.copyWith(
//                       color: context.blackColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             SizedBox(width: width * 0.04),
//
//             /// RIGHT – Image with blue card behind
//             Expanded(
//               flex: 5,
//               child: SizedBox(
//                 height: 350,
//                 child: Stack(
//                   clipBehavior: Clip.none, // allow overlap outside bounds
//                   children: [
//                     // BLUE BACKGROUND CARD (shifted up and left)
//                     Positioned(
//                       top: -35,
//                       // 🔵 move upward
//                       left: -34,
//                       // 🔵 move left
//                       right: 40,
//                       // keep some spacing on right
//                       bottom: 40,
//                       // keep some spacing on bottom
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: const Color(0xFF002A93),
//                           borderRadius: BorderRadius.circular(32),
//                         ),
//                       ),
//                     ),
//
//                     // FOREGROUND IMAGE (slightly downwards)
//                     Positioned(
//                       top: 0,
//                       left: 0,
//                       right: 0,
//                       bottom: 0,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(28),
//                         child: Image.asset(
//                           Assets.images.aboutUs.path,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
