import 'package:digify_app/core/extensions/colors.dart';
import 'package:digify_app/core/extensions/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRadioTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String title;
  final ValueChanged<T> onChanged;
  final bool showBottomBorder;

  const CustomRadioTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.title,
    required this.onChanged,
    this.showBottomBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Container(
        decoration: BoxDecoration(
          border:
              showBottomBorder
                  ? Border(
                    bottom: BorderSide(color: context.blackColor.withAlpha(26)),
                  )
                  : null,
        ),
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Row(
          children: [
            // Circle Radio UI
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? context.primaryColor : Colors.grey,
                  width: 2,
                ),
              ),
              child:
                  isSelected
                      ? Center(
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: context.primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                      : null,
            ),
            const SizedBox(width: 10),
            // Title Text
            Text(
              title,
              style: context.text16Medium.copyWith(
                color: isSelected ? Colors.black : Colors.grey,
                // decoration:
                //     isSelected ? TextDecoration.none : TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
