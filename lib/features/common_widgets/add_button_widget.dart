import 'package:digify_app/features/common_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddButtonWidget extends StatelessWidget {
  const AddButtonWidget({super.key, required this.title, required this.onTap});

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(top: 20.h, bottom: 20.h,right: 20.w),
        child: customUploadBtnWidget(
          onTap:onTap,
          width: 200,
          height: 0.05.sh,
          text: title,
          context: context,
          borderRadius: 10,
        ),
      ),
    );
  }
}
