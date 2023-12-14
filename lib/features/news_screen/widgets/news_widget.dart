import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String time;

  const NewsWidget(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.w, right: 15.w),
      width: double.infinity,
      height: 225.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            width: double.infinity,
            height: 137.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.w, right: 10.w),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
            child: Row(
              children: [
                Text(
                  time,
                  style: TextStyle(
                    color: const Color(0xFF7A7A7A),
                    fontSize: 12.sp,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin:  EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
            child:  Text(
              'Толығырақ',
              style: TextStyle(
                color: const Color(0xFF1E88E5),
                fontSize: 12.sp,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
