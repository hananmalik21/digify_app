import 'package:digify_app/core/extensions/colors.dart';
import 'package:digify_app/core/extensions/textstyles.dart';
import 'package:flutter/material.dart';

Widget customUploadBtnWidget({
  required String text,
  required BuildContext context,
  VoidCallback? onTap,
  bool isLoading = false,
  bool isEnable = true,
  Color? buttonColor,
  Color? textColor,
  Color? loaderColor,
  TextStyle? textStyle,
  double height = 38,
  double? width,
  double borderRadius = 8,
  Color borderColor = Colors.transparent, // ✅ added
}) {
  return SizedBox(
    height: height,
    width: width,
    child: ElevatedButton(
      onPressed: (isEnable && !isLoading) ? onTap : null,

      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: isEnable
            ? (buttonColor ?? context.primaryColor)
            : const Color(0xFFB8860B),

        disabledBackgroundColor: const Color(0xFFB8860B),

        padding: const EdgeInsets.symmetric(horizontal: 16),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: borderColor), // ✅ added
        ),
      ),

      child: isLoading
          ? SizedBox(
        height: 18,
        width: 18,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: loaderColor ?? Colors.white,
        ),
      )
          : Text(
        text,
        style: textStyle ??
            context.text14Medium.copyWith(
              fontWeight: FontWeight.w600,
              color: isEnable
                  ? (textColor ?? Colors.white)
                  : Colors.black54,
            ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}


// Widget customUploadBtnWidget({
//   icon,
//   required String text,
//   double? width,
//   VoidCallback? onTap,
//   bool isLoading = false,
//   bool isAnimated = false,
//   bool isEnable = true,
//   required BuildContext context,
//   Color? loaderColor,
//   Color? buttonColor,
//   TextStyle? textStyle,
//   Color borderColor = Colors.transparent,
//   Color? textColor,
//   double height = 50,
//   double? fontSize,
//   double borderRadius = 6,
//   double loaderSize = 15,
// }) {
//   final ValueNotifier<bool> isHovered = ValueNotifier(false);
//
//   return ValueListenableBuilder<bool>(
//     valueListenable: isHovered,
//     builder: (context, hovered, _) {
//       final effectiveColor = isEnable
//           ? (buttonColor ?? context.primaryColor)
//           : const Color(0xFFB8860B); // Dark Yellow when disabled
//
//       Widget child = AnimatedContainer(
//         duration: const Duration(milliseconds: 150),
//         curve: Curves.easeInOut,
//         padding: const EdgeInsets.all(5),
//         height: height.h,
//         width: width?.w ?? double.infinity,
//         decoration: BoxDecoration(
//           color: isEnable && hovered
//               ? effectiveColor.withOpacity(0.85)
//               : effectiveColor,
//           borderRadius: BorderRadius.circular(isAnimated ? 25 : borderRadius),
//           border: Border.all(color: borderColor),
//           boxShadow: isEnable && hovered
//               ? [
//             BoxShadow(
//               color: effectiveColor.withOpacity(0.3),
//               blurRadius: 8,
//               offset: const Offset(0, 4),
//             ),
//           ]
//               : [],
//         ),
//         child: isLoading
//             ? Center(
//           child: SizedBox(
//             height: loaderSize,
//             width: loaderSize,
//             child: CupertinoActivityIndicator(
//               color: loaderColor ?? Colors.white,
//               animating: true,
//             ),
//           ),
//         )
//             : Center(
//           child: CustomText(
//             text: text,
//             maxLines: 2,
//             textStyle: textStyle ??
//                 context.text14Medium.copyWith(
//                   fontWeight: FontWeight.w600,
//                   color: isEnable
//                       ? textColor ?? context.textFieldColor
//                       : Colors.black54,
//                 ),
//           ),
//         ),
//       );
//
//       // Wrap with GestureDetector only if enabled and not loading
//       if (isEnable && !isLoading && onTap != null) {
//         child = GestureDetector(
//           onTap: onTap,
//           child: child,
//         );
//       }
//
//       return MouseRegion(
//         onEnter: isEnable ? (_) => isHovered.value = true : null,
//         onExit: isEnable ? (_) => isHovered.value = false : null,
//         cursor: isEnable && !isLoading
//             ? SystemMouseCursors.click
//             : SystemMouseCursors.basic,
//         child: child,
//       );
//     },
//   );
// }
