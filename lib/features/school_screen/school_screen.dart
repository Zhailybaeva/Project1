import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ok_edus_kz/generated/l10n.dart';
import 'package:ok_edus_kz/utils/custom_snackbar.dart';

class SchoolScreen extends StatelessWidget {
  const SchoolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          S.of(context).HomeWork,
          style: TextStyle(
            color: Colors.black,
            fontFamily: "SF Pro Display",
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(children: [
        Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 140.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.r),
                      bottomRight: Radius.circular(30.r))),
              child: Column(
                children: [
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF03A9F4),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    margin:
                        EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
                    height: 100.h,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 15.h),
                          child: Row(
                            children: [
                              Text(
                                S.of(context).UBTreadyness,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.sp,
                                    fontFamily: "SF Pro Display",
                                    fontWeight: FontWeight.w500),
                              ),
                              const Spacer(),
                              Text(
                                S.of(context).Today,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                    fontFamily: "SF Pro Display",
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            children: [
                              Text(
                                '${S.of(context).Time}:',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontFamily: "SF Pro Display",
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '15:00',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontFamily: "SF Pro Display",
                                    fontWeight: FontWeight.w500),
                              ),
                              const Spacer(),
                              SizedBox(
                                  width: 35.w,
                                  height: 30.h,
                                  child: Image.asset(
                                    'images/books.png',
                                    fit: BoxFit.cover,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                               
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                backgroundColor:
                                    Colors.white, // Удалите внутренние отступы
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ), // Цвет фона кнопки
                              ),
                              child: Container(
                                width: 65.w,
                                height: 65.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 10.h),
                                  child: SvgPicture.asset(
                                      'images/school_icons/sabak_keste.svg'),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5.h),
                              child: Text(
                                S.of(context).Schedule,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontFamily: "SF Pro Display",
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                                                      showCustomSnackBar(context);

                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor:
                                Colors.white, // Удалите внутренние отступы
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ), // Цвет фона кнопки
                          ),
                          child: Container(
                            width: 65.w,
                            height: 65.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                child: SvgPicture.asset(
                                    'images/school_icons/journal.svg')),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5.h),
                          child: Text(
                            S.of(context).Journal,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontFamily: "SF Pro Display",
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                                                     showCustomSnackBar(context);

                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor:
                                Colors.white, // Удалите внутренние отступы
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ), // Цвет фона кнопки
                          ),
                          child: Container(
                            width: 65.w,
                            height: 65.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Container(
                              margin: EdgeInsets.all(10.r),
                              child: SvgPicture.asset(
                                  'images/school_icons/pander.svg'),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5.h),
                          child: Text(
                            S.of(context).Subjects,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontFamily: "SF Pro Display",
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                                                     showCustomSnackBar(context);

                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor:
                                Colors.white, // Удалите внутренние отступы
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ), // Цвет фона кнопки
                          ),
                          child: Container(
                            width: 65.w,
                            height: 65.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                child: SvgPicture.asset(
                                    'images/school_icons/ui_zhumysy.svg')),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5.h),
                          child: Text(
                            S.of(context).HomeWork,
                            overflow: TextOverflow.ellipsis, // Add this line

                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontFamily: "SF Pro Display",
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                                                   showCustomSnackBar(context);

                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor:
                              Colors.white, // Удалите внутренние отступы
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ), // Цвет фона кнопки
                        ),
                        child: Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 10.w),
                              child: SvgPicture.asset(
                                  'images/school_icons/birlestik.svg')),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.h),
                        child: Text(
                          S.of(context).Community,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontFamily: "SF Pro Display",
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                                                    showCustomSnackBar(context);

                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor:
                              Colors.white, // Удалите внутренние отступы
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ), // Цвет фона кнопки
                        ),
                        child: Container(
                          width: 65.w,
                          height: 65.h,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 10.w),
                              child: SvgPicture.asset(
                                  'images/school_icons/oku_materialdary.svg')),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.h),
                        child: Text(
                          S.of(context).SubjectMaterials,
                          overflow: TextOverflow.ellipsis, // Add this line

                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontFamily: "SF Pro Display",
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                                                    showCustomSnackBar(context);

                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor:
                              Colors.white, // Удалите внутренние отступы
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10).r,
                          ), // Цвет фона кнопки
                        ),
                        child: Container(
                          width: 65.w,
                          height: 65.h,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: SvgPicture.asset(
                                  'images/school_icons/info.svg')),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.h),
                        child: Text(
                          S.of(context).Info,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontFamily: "SF Pro Display",
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 65.w,
                    height: 65.h,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).Additional,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontFamily: "SF Pro Display",
                    fontWeight: FontWeight.w500),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showCustomSnackBar(context);
                        },
                        child: Container(
                          width: 65.w,
                          height: 65.h,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 10.w),
                              child:
                                  Image.asset('images/school_icons/test.png')),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.h),
                        child: Text(
                          S.of(context).Test,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontFamily: "SF Pro Display",
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showCustomSnackBar(context);
                        },
                        child: Container(
                          width: 65.w,
                          height: 65.h,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 10.w),
                              child: Image.asset(
                                  'images/school_icons/video_sabak.png')),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.h),
                        child: Text(
                          S.of(context).VideoLessons,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontFamily: "SF Pro Display",
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showCustomSnackBar(context);
                        },
                        child: Container(
                          width: 65.w,
                          height: 65.h,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 10.w),
                              child:
                                  Image.asset('images/school_icons/quiz.png')),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.h),
                        child: Text(
                          S.of(context).Quiz,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontFamily: "SF Pro Display",
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showCustomSnackBar(context);
                        },
                        child: Container(
                          width: 65.w,
                          height: 65.h,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 10.h),
                              child: SvgPicture.asset(
                                  'images/school_icons/zhazba.svg')),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.h),
                        child: Text(
                          S.of(context).Writing,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontFamily: "SF Pro Display",
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 60.h),
          ],
        ),
      ]),
    );
  }
}
