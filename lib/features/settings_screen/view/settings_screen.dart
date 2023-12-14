import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ok_edus_kz/features/profile_screen/profile_bloc/profile_bloc.dart';
import 'package:ok_edus_kz/features/profile_screen/profile_bloc/profile_event.dart';
import 'package:ok_edus_kz/generated/l10n.dart';
import 'package:ok_edus_kz/features/settings_screen/repo/logout_repo.dart';
import 'package:ok_edus_kz/features/auth_screen/view/auth_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({
    super.key,
  });

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final LogoutService logoutService = LogoutService();

  bool pushNotifications = true; // Переменная состояния для первого Switch
  bool smsNotifications = true; // Переменная состояния для второго Switch

  String selectedLanguage = 'Казақ'; // Исходный выбранный язык

  Future<void> loadSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final language = prefs.getString('selectedLanguage');
    if (language != null) {
      setState(() {
        selectedLanguage = language;
      });
    }
  }

  Future<void> saveSelectedLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', language);
  }

  @override
  void initState() {
    loadSelectedLanguage();
    super.initState();
  }

  // Функция для изменения языка
  void openLanguageSelectionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 140.h,
          child: Column(
            children: [
              ListTile(
                title: const Text('Казақ'),
                onTap: () {
                  setState(() {
                    selectedLanguage = 'Казақ';
                    S.load(const Locale('kk')); // Set Kazakh language
                    saveSelectedLanguage('kk'); // Save selected language
                  });
                  Navigator.pop(context);
                },
              ),
              const Divider(
                thickness: 1,
                endIndent: 0,
                indent: 0,
                color: Colors.grey,
              ),
              ListTile(
                title: const Text('Русский'),
                onTap: () {
                  setState(() {
                    selectedLanguage = 'Русский';
                    S.load(const Locale('ru')); // Set Russian language
                    saveSelectedLanguage('ru'); // Save selected language
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          S.of(context).Settings,
          style: TextStyle(
            color: Colors.black,
            fontFamily: "SF Pro Display",
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            BlocProvider.of<ProfileBloc>(context).add(FetchProfileEvent());
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 20.h,
                left: 25.w,
                right: 25.r,
              ),
              child: Row(
                children: [
                  Text(
                    S.of(context).PushNotifications,
                    style: TextStyle(
                      color: const Color(0xFF1F2024),
                      fontSize: 14.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                    ),
                  ),
                  const Spacer(),
                  Switch.adaptive(
                    value: pushNotifications,
                    activeColor: const Color(0xFF006FFD),
                    onChanged: (bool value) {
                      setState(() {
                        pushNotifications =
                            value; // Обновляем состояние первого Switch
                      });
                    },
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 0.5,
              endIndent: 25,
              indent: 25,
              color: Colors.grey,
            ),
            Container(
              margin: EdgeInsets.only(
                top: 0.h,
                left: 25.w,
                right: 25.w,
              ),
              child: GestureDetector(
                onTap: () {
                  openLanguageSelectionBottomSheet(context);
                },
                child: Row(
                  children: [
                    Text(
                      S.of(context).Changelanguage,
                      style: TextStyle(
                        color: const Color(0xFF1F2024),
                        fontSize: 14.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.43.h,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 40.h,
                      child: const Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 0.h,
              endIndent: 25.w,
              indent: 25.w,
              color: Colors.grey,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (await canLaunchUrlString(
                          'https://support.edus.kz/')) {
                        await launchUrlString('https://support.edus.kz/');
                      }
                    },
                    child: Text(
                      S.of(context).TechnicalHelp,
                      style: TextStyle(
                        color: const Color(0xFF1F2024),
                        fontSize: 14.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.43.h,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 50.h),
              child: ElevatedButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('isLoggedIn', false);
                  // ignore: use_build_context_synchronously
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthScreen(),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Center(
                  child: Text(
                    S.of(context).Exit,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
