import 'package:digify_app/core/extensions/colors.dart';
import 'package:digify_app/core/extensions/textstyles.dart';
import 'package:digify_app/core/utils/theme.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_text.dart';

class CustomAppbar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppbar({
    this.titleWidget,
    this.actions,
    this.showActions = true,
    this.showTextTitle = false,
    this.showNotification = true,
    this.textTitle,
    this.backgroundColor,
    this.titleColor,
    this.showLeading,
    this.bottomWidget,
    this.onBack,
    this.toolbarHeight = 56,
    super.key,
  });

  final Widget? titleWidget;
  final List<Widget>? actions;
  final bool showActions;
  final bool showTextTitle;
  final Function()? onBack;
  final bool showNotification;
  final double toolbarHeight;
  final PreferredSize? bottomWidget;
  final String? textTitle;
  final Color? backgroundColor;
  final Color? titleColor;
  final bool? showLeading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      leadingWidth: 80,
      leading:
          showLeading != null
              ? GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onBack != null ? onBack!() : Navigator.pop(context),
                child: Container(
                  margin: EdgeInsets.only(
                    left: 12.w,
                    right: 24.w,
                    top: 12.w,
                    bottom: 12.w,
                  ),
                  child: Center(
                    child: Icon(
                      CupertinoIcons.back,
                      color: context.blackColor,
                      size: 24,
                    ),
                  ),
                ),
              )
              : null,
      backgroundColor: backgroundColor ?? Theme.of(context).cardColor,
      centerTitle: true,
      elevation: 5,
      title: CustomText(
        text: textTitle ?? "",
        textStyle: context.text18SemiBold.copyWith(color: titleColor),
      ),
      actions: actions
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}

Widget badge({required Widget child, required int unreadAlerts}) {
  return Badge(
    backgroundColor: ThemeType.errorColor,
    isLabelVisible: unreadAlerts != 0,
    smallSize: 20,
    textColor: ThemeType.whiteColor,
    label: Text("+${(unreadAlerts).toString()}"),
    child: child,
  );
}
