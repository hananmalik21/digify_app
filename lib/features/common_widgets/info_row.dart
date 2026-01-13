import 'package:digify_app/core/extensions/textstyles.dart';
import 'package:digify_app/features/common_widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(child: Text(label, style: context.text14SemiBold)),
          ),
          Expanded(
            child: Text(
              textAlign: TextAlign.right,
              value,
              style: context.text14Regular.copyWith(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoRowWithDivider extends StatelessWidget {
  const InfoRowWithDivider({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(

              child: Text(
                  textAlign: TextAlign.right,
                  label, style: context.text14SemiBold),
            ),
            20.horizontalSpace,
            Expanded(

              child: Text(
                textAlign: TextAlign.left,
                value,
                style: context.text14Regular.copyWith(color: Colors.black87),
              ),
            ),
          ],
        ),
        CustomDivider(),
      ],
    );
  }
}
