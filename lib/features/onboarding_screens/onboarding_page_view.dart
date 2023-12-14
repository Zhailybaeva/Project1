import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ok_edus_kz/features/onboarding_screens/onboarding_screen_1.dart';
import 'package:ok_edus_kz/features/onboarding_screens/onboarding_screen_2.dart';
import 'package:ok_edus_kz/features/onboarding_screens/onboarding_screen_3.dart';
import 'package:ok_edus_kz/features/onboarding_screens/onboarding_screen_4.dart';
import 'package:ok_edus_kz/features/onboarding_screens/onboarding_screen_5.dart';
import 'package:ok_edus_kz/features/onboarding_screens/page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageViewOnBoarding extends StatefulWidget {
  const PageViewOnBoarding({super.key});

  @override
  State<PageViewOnBoarding> createState() => _PageViewOnBoardingState();
}

class _PageViewOnBoardingState extends State<PageViewOnBoarding> {
  final PageController controller = PageController();
  int currentPage = -1; // Initialize to -1

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    currentPage = 0; // Установите начальное значение currentPage в 0
  }

  Future<void> completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingCompleted', true);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: <Widget>[
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (int page) {
                  setState(() {
                    if (page == 0) {
                      currentPage =
                          -1; // Скрываем PageIndicator на первом экране
                    } else {
                      currentPage =
                          page; // Отображаем PageIndicator на остальных экранах
                    }
                  });
                },
                children: <Widget>[
                  OnBoardingScreenFirst(controller: controller), // Page 1
                  OnBoardingScreenSecond(controller: controller), // Page 2
                  OnBoardingScreenThird(controller: controller), // Page 3
                  OnBoardingScreenFourth(controller: controller), // Page 4
                  OnBoardingScreenFiveth(
                    controller: controller,
                  ),
                ],
              ),
            ),
          ],
        ),
        if (currentPage >= 1)
          Positioned(
            top: MediaQuery.of(context).size.height *
                0.3, // Регулируйте вертикальное позиционирование здесь
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(top: 400.h),
              child: Align(
                  alignment: Alignment.center,
                  child: PageIndicator(
                      pageCount: 4, currentPage: currentPage - 1)),
            ),
          ),
      ],
    );
  }
}
