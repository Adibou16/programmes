import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color header;
  final Color text;
  final Color border;

  const AppColors({
    required this.header,
    required this.text,
    required this.border,
  });

  @override
  AppColors copyWith({
    Color? tableHeader,
    Color? tableText,
    Color? tableBorder,
  }) {
    return AppColors(
      header: tableHeader ?? header,
      text: tableText ?? text,
      border: tableBorder ?? border,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      header: Color.lerp(header, other.header, t)!,
      text: Color.lerp(text, other.text, t)!,
      border: Color.lerp(border, other.border, t)!,
    );
  }
}