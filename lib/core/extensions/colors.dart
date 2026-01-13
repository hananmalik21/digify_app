import 'package:flutter/material.dart';

extension ColorByContext on BuildContext {
  Color get primaryColor => Theme.of(this).primaryColor;

  Color get secondaryColor => Theme.of(this).colorScheme.secondary;

  Color get scaffoldColor => Theme.of(this).scaffoldBackgroundColor;

  Color get backgroundColor => Theme.of(this).scaffoldBackgroundColor;

  Color get textColor => Color(0xff000000);

  Color get blackColor => Color(0xff000000);

  Color get gray70TextColor => Color(0xff7D7D7D);

  Color get gray99TextColor => Color(0xff999999);

  Color get gray86TextColor => Color(0xff868686);

  Color get gray9FTextColor => Color(0xff9F9F9F);

  Color get grayF3TextColor => Color(0xffF3F3F3);

  Color get grayD9TextColor => Color(0xffD9D9D9);

  Color get grayText70Color => Colors.white70;

  Color get grayBg => Colors.grey;

  Color get errorColor => Color(0xffEB5757);

  Color get textFieldColor => Color(0xffF3F3F3);

  Color get cardColor => Theme.of(this).cardColor;

  Color get accentColor => Theme.of(this).colorScheme.secondary;

  Color get buttonColor => Theme.of(this).colorScheme.primary;

  Color get greenCardColor => Color(0xffA7ED9C);

  Color get yellowCardColor => Color(0xffFFD561);

  Color get greenTextColor => Color(0xff00C551);
  Color get whiteColor => Color(0xffffffff);

  // Navigation utilities
  push(Widget page) {
    Navigator.of(this).push(MaterialPageRoute(builder: (_) => page));
  }

  void pushReplacement(Widget page) {
    Navigator.of(this).pushReplacement(MaterialPageRoute(builder: (_) => page));
  }

  void pushAndRemoveUntil(Widget page) {
    Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  void pop() {
    if (Navigator.of(this).canPop()) {
      Navigator.of(this).pop();
    }
  }
}
