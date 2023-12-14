import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ok_edus_kz/generated/l10n.dart';
import 'package:ok_edus_kz/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreenFirst extends StatefulWidget {
  const OnBoardingScreenFirst({super.key, required this.controller});
  final PageController controller;

  @override
  State<OnBoardingScreenFirst> createState() => _OnBoardingScreenFirstState();
}

class _OnBoardingScreenFirstState extends State<OnBoardingScreenFirst>
    with TickerProviderStateMixin {
  MyApp updateColors = const MyApp();
  String? selectedLanguage; // Изначально выбран казахский язык
  late AnimationController _controller;
  late Animation<Offset> _flowerAnimation;
  late Animation<Offset> _dropAnimation;
  late Animation<Offset> _starAnimation;

  @override
  void initState() {
    super.initState();
    loadSelectedLanguage();
    _controller = AnimationController(
      duration: const Duration(seconds: 1), // Adjust the duration as needed
      vsync: this,
    );

    _flowerAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0), // Starting position off-screen
      end: const Offset(0.15, 0.035), // Ending position on-screen
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Adjust the curve as needed
    ));

    _dropAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Starting position off-screen
      end: const Offset(0.57, 0.15), // Ending position on-screen
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Adjust the curve as needed
    ));

    _starAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0), // Starting position off-screen
      end: const Offset(0.08, 0.48), // Ending position on-screen
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

  Future<void> loadSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final language = prefs.getString('selectedLanguage');
    if (language != null) {
      setState(() {
        selectedLanguage = (language == 'ru') ? 'Русский' : 'Казахский';
      });
    } else {
      // Если нет сохраненного языка, установите казахский как значение по умолчанию
      selectedLanguage = null;
      await saveSelectedLanguage('kk');
    }
  }

  Future<void> saveSelectedLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    
        await prefs.setString('selectedLanguage', language);
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
                    Text(
                      'Тілді таңдаңыз',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFFF5F5F5),
                        fontSize: 24.sp,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Выберите язык',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFFF5F5F5),
                        fontSize: 24.sp,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 125),
                // Добавление DropdownButton для выбора языка
                Container(
                  width: double.infinity,
                  margin:  EdgeInsets.symmetric(horizontal: 35.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 16.0.w),
                    child: Form(
                      child: DropdownButtonFormField<String>(
                        isDense: true,
                        borderRadius: BorderRadius.circular(10),
                        value: selectedLanguage,
                        onChanged: (String? newValue) async {
                          if (newValue == null) {
                            // Handle the case where the user does not select a language
    
                            await saveSelectedLanguage(
                                'kk'); // Save selected language
                          }
    
                          if (newValue == 'Русский') {
                            S.load(const Locale('ru')); // Устанавливаем русский язык
                            await saveSelectedLanguage(
                                'ru'); // Save selected language
                          } else if (newValue == 'Казахский') {
                            S.load(
                                const Locale('kk')); // Устанавливаем казахский язык
                            await saveSelectedLanguage(
                                'kk'); // Save selected language
                          }
                            setState(() {
                              selectedLanguage = newValue;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Выберите язык'; // Validation error message
                            }
                            return null; // No validation error
                          },
                          items: <String>['Казахский', 'Русский']
                              .map((String value) {
                                
                            return DropdownMenuItem<String>(
                          
                              value: value,
                              child: Text(
                                value,
                                style:  TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black87,
                                ),
                              ),
                            );
                          }).toList(),
                          decoration: const InputDecoration(
                            hintText: 'Выберите язык',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                   SizedBox(height: 40.h),
                  Container(
                    width: double.infinity,
                    margin:  EdgeInsets.symmetric(horizontal: 35.w),
                    child: ElevatedButton(
                      onPressed: () {
                        widget.controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding:  EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 14.h),
                        backgroundColor: const Color(0xFFFFBF01),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child:  Text(
                        'Бастау',
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
