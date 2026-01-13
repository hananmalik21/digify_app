import 'package:digify_app/core/extensions/colors.dart';
import 'package:flutter/widgets.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: EdgeInsets.symmetric(vertical: 12),
      color: context.blackColor.withAlpha(20),
    );
  }
}
