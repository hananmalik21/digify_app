import 'package:digify_app/core/extensions/textstyles.dart';
import 'package:digify_app/features/common_widgets/info_row.dart';
import 'package:digify_app/features/common_widgets/newmorphic_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DynamicInfoSection extends StatelessWidget {
  final String title;
  final bool hideTitle;
  final List<InfoItem> items;
  final Alignment alignment;

  const DynamicInfoSection({
    super.key,
    required this.title,
    required this.items,
    this.hideTitle = false,
    this.alignment = Alignment.topLeft,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: alignment,          // prevents stretching
      child: IntrinsicWidth(                 // makes width as small as content
        child: NeumorphicCard(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,   // shrink vertically
              children: [
                if (!hideTitle)
                  Center(
                    child: Text(
                      title,
                      style: context.text20SemiBold.copyWith(
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                SizedBox(height: 30.h),

                ...items.map(
                      (e) => InfoRowWithDivider(
                    label: e.label,
                    value: e.value ?? "-",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class InfoItem {
  final String label;
  final String? value;

  InfoItem({required this.label, this.value});
}
