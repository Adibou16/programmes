import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color tableHeader;
  final Color tableText;
  final Color tableBorder;

  const AppColors({
    required this.tableHeader,
    required this.tableText,
    required this.tableBorder,
  });

  @override
  AppColors copyWith({
    Color? tableHeader,
    Color? tableText,
    Color? tableBorder,
  }) {
    return AppColors(
      tableHeader: tableHeader ?? this.tableHeader,
      tableText: tableText ?? this.tableText,
      tableBorder: tableBorder ?? this.tableBorder,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      tableHeader: Color.lerp(tableHeader, other.tableHeader, t)!,
      tableText: Color.lerp(tableText, other.tableText, t)!,
      tableBorder: Color.lerp(tableBorder, other.tableBorder, t)!,
    );
  }
}