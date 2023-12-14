import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ok_edus_kz/generated/l10n.dart';
import 'package:ok_edus_kz/features/auth_screen/view/auth_screen.dart';

class OnBoardingScreenFourth extends StatefulWidget {
  final PageController controller;
  const OnBoardingScreenFourth({super.key, required this.controller});

  @override
  State<OnBoardingScreenFourth> createState() => _OnBoardingScreenFourthState();
}

class _OnBoardingScreenFourthState extends State<OnBoardingScreenFourth>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _flowerAnimation;
  late Animation<Offset> _dropAnimation;
  late Animation<Offset> _starAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1), // Adjust the duration as needed
      vsync: this,
    );

    _flowerAnimation = Tween<Offset>(
      begin: const Offset(0.21, 0.0), // Starting position off-screen
      end: const Offset(0.21, -0.015), // Ending position on-screen
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Adjust the curve as needed
    ));

    _dropAnimation = Tween<Offset>(
      begin: const Offset(0.3, 0.2), // Starting position off-screen
      end: const Offset(0.17, 0.17), // Ending position on-screen
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Adjust the curve as needed
    ));

    _starAnimation = Tween<Offset>(
      begin: const Offset(0.18, 0.4), // Starting position off-screen
      end: const Offset(0.20, 0.4), // Ending position on-screen
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Adjust the curve as needed
    ));

    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the AnimationController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF8BE1DE), Color(0xFF398FA3)],
          ),
        ),
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _flowerAnimation,
              builder: (BuildContext context, Widget? child) {
                return Positioned(
                  left: MediaQuery.of(context).size.width *
                      _flowerAnimation.value.dx,
                  top: MediaQuery.of(context).size.height *
                      _flowerAnimation.value.dy,
                  child:
                      SvgPicture.asset('images/geometric_figures/flower.svg'),
                );
              },
            ),
            AnimatedBuilder(
              animation: _dropAnimation,
              builder: (BuildContext context, Widget? child) {
                return Positioned(
                  left: MediaQuery.of(context).size.width *
                      _dropAnimation.value.dx,
                  top: MediaQuery.of(context).size.height *
                      _dropAnimation.value.dy,
                  child: SvgPicture.asset('images/geometric_figures/drop.svg'),
                );
              },
            ),
            AnimatedBuilder(
              animation: _starAnimation,
              builder: (BuildContext context, Widget? child) {
                return Positioned(
                  left: MediaQuery.of(context).size.width *
                      _starAnimation.value.dx,
                  top: MediaQuery.of(context).size.height *
                      _starAnimation.value.dy,
                  child: SvgPicture.asset('images/geometric_figures/star.svg'),
                );
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(height: 40.h),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return const AuthScreen();
                          }),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 20.w, bottom: 80.h),
                        alignment: Alignment.topRight,
                        child: Text(
                          'Өткізу',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Image.asset(
                      'images/oqushi3.png',
                      height: 256.h,
                      width: 256.w,
                    ),
                    SizedBox(height: 70.h),
                    Text(
                      S.of(context).HomeWorkT,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 35.w),
                      child: Text(
                        S.of(context).HomeWorkText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 120.h),
                Container(
                  width: double.infinity,
                  margin:
                      EdgeInsets.only(left: 35.w, right: 35.w, bottom: 70.h),
                  child: ElevatedButton(
                    onPressed: () {
                      widget.controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 14.h),
                      backgroundColor: const Color(0xFFFFBF01),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      S.of(context).Next,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
