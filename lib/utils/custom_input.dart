import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInputDecorations {
  static InputDecoration loginInputDecoration() {
    return InputDecoration(
      labelText: "Логин",
      labelStyle: TextStyle(
        color: Colors.grey, // Задайте желаемый цвет для текста метки
        fontSize: 17.sp,
        fontFamily: "SF Pro Display",
        fontWeight: FontWeight.w400,
      ),
      // Остальные настройки декорации, такие как рамка, фон и т. д.
      // Вы также можете добавить их сюда.
    );
  }
}
