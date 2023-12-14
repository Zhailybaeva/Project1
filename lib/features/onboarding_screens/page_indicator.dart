import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageIndicator extends StatelessWidget {
  final int pageCount;
  final int currentPage;

  const PageIndicator({super.key, required this.pageCount, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    List<Widget> dots = [];

    for (int i = 0; i < pageCount; i++) {
      dots.add(
        Container(
          width: 13.w,
          height: 13.h,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == currentPage
                ? const Color(0xFFFFC107)
                : const Color(0xFFD9D9D9),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: dots,
    );
  }
}
