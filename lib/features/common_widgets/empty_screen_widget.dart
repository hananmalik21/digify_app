import 'package:digify_app/core/extensions/textstyles.dart';
import 'package:digify_app/features/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyScreenWidget extends StatelessWidget {
  const EmptyScreenWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(Assets.images.emptyViewImg.path, height: 103, width: 103),
          30.verticalSpace,
          CustomText(text: "No $title yet!", textStyle: context.text24SemiBold),
        ],
      ),
    );
  }
}
