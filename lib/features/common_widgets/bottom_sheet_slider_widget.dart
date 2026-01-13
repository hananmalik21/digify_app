import 'package:digify_app/core/extensions/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetSliderWidget extends StatelessWidget {
  const BottomSheetSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5.h,
      width: 53.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: context.grayD9TextColor,
      ),
    );
  }
}
