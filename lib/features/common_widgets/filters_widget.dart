import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FiltersIcon extends StatelessWidget {
  const FiltersIcon({
    super.key, required this.onTap,
  });

  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        height: 48.h,
        width: 48.h,
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 13),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xff6C6A6A),width: 0.6),
            borderRadius: BorderRadius.circular(8)
        ),
        // child: SvgPicture.asset(Assets.images.filterIcon),
      ),
    );
  }
}
