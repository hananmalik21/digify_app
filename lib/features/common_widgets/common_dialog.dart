import 'package:digify_app/core/extensions/colors.dart';
import 'package:digify_app/core/extensions/textstyles.dart';
import 'package:digify_app/core/utils/theme.dart';
import 'package:digify_app/features/common_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteDialogWidget extends StatelessWidget {
  const DeleteDialogWidget({super.key, required this.onClick});

  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),

      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: ThemeType.whiteColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          20.verticalSpace,
          Text(
            'Confirm Delete',
            style: context.text18SemiBold.copyWith(
              color: context.grayText70Color,
            ),
            textAlign: TextAlign.center,
          ),
          5.verticalSpace,
          Text(
            "Do you really want to delete this department?",

            textAlign: TextAlign.center,
            style: context.text14Medium.copyWith(
              color: context.gray70TextColor,
            ),
          ),

          30.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customUploadBtnWidget(
                onTap: () => Navigator.pop(context),
                height: 40,
                width: 130,
                text: "Cancel",
                textColor: context.primaryColor,
                borderColor: context.primaryColor,
                buttonColor: context.scaffoldColor,
                context: context,
                textStyle: context.text14SemiBold.copyWith(
                  color: context.primaryColor,
                ),
              ),
              14.horizontalSpace,
              customUploadBtnWidget(
                onTap: () {
                  onClick();
                  Navigator.pop(context);
                },
                height: 40,
                width: 130,

                text: "Delete",
                textColor: context.blackColor,
                borderColor: context.primaryColor,
                buttonColor: context.primaryColor.withOpacity(0.7),
                context: context,
                textStyle: context.text14SemiBold.copyWith(
                  color: context.blackColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
