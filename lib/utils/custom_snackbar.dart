import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

void showCustomSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.white,
      content: Row(
        children: [
          SvgPicture.asset('images/attention.svg'),
           SizedBox(width: 5.w),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 5.w, right: 5.w),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Бұл бөлімдер әзірге қол жетімді емес.',
                    style: TextStyle(
                      color:const  Color(0xFF4F4F4F),
                      fontSize: 14.sp,
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Жүргізіліп жатырған өзгерістерге байланысты жақын арада қосылатын болады.',
                    style: TextStyle(
                      color: const Color(0xFF4F4F4F),
                      fontSize: 13.sp,
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 225.h,
        right: 20.w,
        left: 20.w,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}

