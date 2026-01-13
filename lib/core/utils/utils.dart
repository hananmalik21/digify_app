import 'package:digify_app/core/extensions/colors.dart';
import 'package:digify_app/core/utils/theme.dart' show ThemeType;
import 'package:digify_app/features/common_widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show AlertDialog, Divider, TextButton, showDialog, showModalBottomSheet;
import 'package:flutter_screenutil/flutter_screenutil.dart' show ScreenUtil;
import 'package:fluttertoast/fluttertoast.dart' show Fluttertoast, ToastGravity, Toast;


class Utils {
  // Private constructor
  Utils._privateConstructor();

  // Single instance
  static final Utils _instance = Utils._privateConstructor();

  // Factory constructor to return the same instance
  factory Utils() {
    return _instance;
  }

  void showCustomDialog(
    BuildContext context,
    Widget child, {
    bool canPop = true,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents tap outside to close
      builder: (BuildContext context) {
        return PopScope(
          canPop: canPop, // Prevents back button to close
          child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            backgroundColor: context.scaffoldColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            content: Container(
              // width:
              //     MediaQuery.of(context).size.width *
              //     0.8, // 80% of screen width
              padding: EdgeInsets.all(20),
              child: child,
            ),
          ),
        );
      },
    );
  }

  showToast(String msg, {bool success = true, bool isInfo = false}) {
    Fluttertoast.showToast(
      backgroundColor:
          isInfo
              ? ThemeType.warningColor
              : success
              ? ThemeType.successColor
              : ThemeType.errorColor,
      textColor: ThemeType.whiteColor,
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 12.0,

    );
  }

  void showDatePicker({
    required BuildContext context,
    DateTime? minDate,
    DateTime? maxDate,
    required Function(DateTime? date) onDateSelection,
  }) {
    DateTime? tempSelectedDate; // Temporary date to hold the selection

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 350,
          child: Column(
            children: [
              // Buttons at the top
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the picker
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      onDateSelection(tempSelectedDate);
                      Navigator.of(context).pop(); // Close the picker
                    },
                    child: const Text('Done'),
                  ),
                ],
              ),
              const Divider(height: 1),
              // CupertinoDatePicker below
              Expanded(
                child: CupertinoDatePicker(
                  minimumDate: minDate ?? DateTime.now(),
                  maximumDate:
                      maxDate ??
                      DateTime(
                        DateTime.now().year + 10,
                        DateTime.now().month,
                        DateTime.now().day,
                      ),
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime newDate) {
                    tempSelectedDate = newDate; // Update the temporary date
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  BoxDecoration listingBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.grayBg,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: context.blackColor.withAlpha(41)),
    );
  }

  BoxDecoration itemsDetailBoxDecoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: context.blackColor.withAlpha(41)),
      color: context.grayBg,
    );
  }

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  Widget backButton(BuildContext context, {String? text}) {
    return customUploadBtnWidget(
      onTap: () => Navigator.pop(context),
      buttonColor: context.scaffoldColor,
      borderColor: context.primaryColor,
      textColor: context.primaryColor,
      text: text ?? "Back",
      context: context,
    );
  }

 Future<void> showBottomSheet({required BuildContext context, required Widget view,Function()? thenFunction}) async{
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      isDismissible: true,
      enableDrag: true,
      constraints: BoxConstraints(
        minHeight: ScreenUtil().screenHeight * 0.2,
        maxHeight: ScreenUtil().screenHeight * 0.95,
      ),
      builder: (context) => view,
    ).then((value) => thenFunction!=null?thenFunction():null,);
  }
}
