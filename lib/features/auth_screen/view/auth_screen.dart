import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ok_edus_kz/features/auth_screen/auth_bloc/auth_bloc.dart';
import 'package:ok_edus_kz/features/auth_screen/auth_bloc/auth_event.dart';
import 'package:ok_edus_kz/features/auth_screen/auth_bloc/auth_state.dart';
import 'package:ok_edus_kz/generated/l10n.dart';
import 'package:ok_edus_kz/features/mainscreen_navbar/custom_bottom_navbar.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(context),
      child: Scaffold(
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: const AuthWidget()),
      ),
    );
  }
}

class AuthWidget extends StatelessWidget {
  
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController loginController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        print(state);
        if (state is AuthInitialState) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF8BE1DE), Color(0xFF398FA3)],
            )),
            child: Stack(
              children: [
                Positioned(
                  left: 120.w,
                  top: -80.h,
                  child:
                      SvgPicture.asset('images/geometric_figures/flower.svg'),
                ),
                Positioned(
                  left: 10.w,
                  top: 100.h,
                  child: SvgPicture.asset('images/geometric_figures/drop.svg'),
                ),
                Positioned(
                  left: 200.w,
                  top: 360.h,
                  child: SvgPicture.asset('images/geometric_figures/star.svg'),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).StudentsCabinet,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "SF Pro Display",
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      margin: EdgeInsets.only(left: 20.w, right: 20.w),
                      child: Text(
                        S.of(context).StudentsCabinetText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "SF Pro Display",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(height: 80),
                    Column(
                      children: [
                        Container(
                          width: 320.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Colors.white),
                          child: Container(
                            margin: EdgeInsets.only(left: 15.r),
                            child: TextFormField(
                              controller: loginController,
                              decoration: InputDecoration(
                                  labelText: "Логин",
                                  border: InputBorder.none,
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 17.sp,
                                      fontFamily: "SF Pro Display",
                                      fontWeight: FontWeight.w400)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          width: 320.w,
                          height: 50.h,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(left: 15.w),
                            alignment: Alignment.centerLeft,
                            child: TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                labelText: "Пароль",
                                border: InputBorder.none,
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17.sp,
                                    fontFamily: "SF Pro Display",
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        SizedBox(
                          width: 320.w,
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: () {
                              authBloc.add(LoginEvent(
                                  login: loginController.text,
                                  password: passwordController.text));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFC107),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 14.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            child: Text(
                              S.of(context).Login,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (state is AuthLoggedInState) {
          Future.delayed(Duration.zero, () {
            Navigator.pushAndRemoveUntil<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => const BottomNavBar(),
              ),
              (route) =>
                  false, //if you want to disable back feature set to false
            );
          });
          // You should return a placeholder widget here, or null if you don't want to render anything
          return const SizedBox.shrink(); // This returns an empty widget
        } else if (state is AuthErrorState) {
        final String errorPhrase = state.reasonPhrase;
        Future.delayed(Duration.zero, () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content:  Text('Ошибка: $errorPhrase'),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                duration: const Duration(
                    seconds:
                        5), // Установите желаемую продолжительность в секундах
              ),
            );
          });
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF8BE1DE), Color(0xFF398FA3)],
            )),
            child: Stack(
              children: [
                Positioned(
                  left: 120.w,
                  top: -80.h,
                  child:
                      SvgPicture.asset('images/geometric_figures/flower.svg'),
                ),
                Positioned(
                  left: 10.w,
                  top: 100.h,
                  child: SvgPicture.asset('images/geometric_figures/drop.svg'),
                ),
                Positioned(
                  left: 200.w,
                  top: 360.h,
                  child: SvgPicture.asset('images/geometric_figures/star.svg'),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).StudentsCabinet,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "SF Pro Display",
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        S.of(context).StudentsCabinetText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "SF Pro Display",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(height: 80.h),
                    Column(
                      children: [
                        Container(
                          width: 320.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Colors.white),
                          child: Container(
                            margin: EdgeInsets.only(left: 15.w),
                            child: TextFormField(
                              controller: loginController,
                              decoration: const InputDecoration(
                                  labelText: "Логин", border: InputBorder.none),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          width: 320.w,
                          height: 50.h,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(left: 15.w),
                            alignment: Alignment.centerLeft,
                            child: TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                labelText: "Пароль",
                                border: InputBorder.none,
                                labelStyle: TextStyle(
                                    fontSize: 17.sp,
                                    fontFamily: "SF Pro Display",
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        SizedBox(
                          width: 320.w,
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: () {
                              authBloc.add(LoginEvent(
                                  login: loginController.text,
                                  password: passwordController.text));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFC107),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 14.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            child: Text(
                              S.of(context).Login,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ); // This returns an empty widget
        } else {
          return Center(
            child: Text('$state'),
          );
        }
      },
    );
  }
}
