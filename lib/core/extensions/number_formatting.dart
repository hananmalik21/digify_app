extension NumberFormatting on num {
  String withCommas() {
    final parts = toStringAsFixed(2).split('.');
    final wholePart = parts[0].replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+\$)'),
          (Match match) => "${match[1]},",
    );
    final decimalPart = parts[1] == '00' ? '' : '.${parts[1]}';
    return wholePart + decimalPart;
  }
}
