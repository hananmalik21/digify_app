import 'package:intl/intl.dart';

extension CustomDateFormatting on DateTime {
  String toCustomFormat() {
    // You can change this format as needed
    return DateFormat('dd-MM-yyyy').format(this);
  }
}
