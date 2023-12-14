import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ok_edus_kz/features/profile_screen/profile_bloc/profile_bloc.dart';
import 'package:ok_edus_kz/features/profile_screen/profile_bloc/profile_event.dart';
import 'package:ok_edus_kz/features/profile_screen/profile_bloc/profile_state.dart';
import 'package:ok_edus_kz/generated/l10n.dart';
import 'package:ok_edus_kz/model/profile_model.dart';
import 'package:ok_edus_kz/features/settings_screen/view/settings_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      
      create: (context) => ProfileBloc(),
      child: Builder(builder: (context) {
        final profileBloc = BlocProvider.of<ProfileBloc>(context);
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Профиль',
              style: TextStyle(
                color: Colors.black,
                fontFamily: "SF Pro Display",
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            centerTitle: true,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider<ProfileBloc>.value(
                        value: profileBloc,
                        child: const SettingScreen(),
                      ),
                    ),
                  );
                },
                icon: SvgPicture.asset('images/rightButton.svg'),
              ),
            ],
          ),
          body: RefreshIndicator(
              onRefresh: () {
                final profileBloc = BlocProvider.of<ProfileBloc>(context);
                profileBloc.add(FetchProfileEvent());
                return Future<void>.delayed(const Duration(seconds: 3));
              },
              child:  const ProfileWidget()),
        );
      }),
    );
  }
}

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  // ignore: unused_field
  late Animation _animation;
  // ignore: unused_field
  AnimationStatus _status = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween(end: 1.0, begin: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _status = status;
      });
  }

  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(FetchProfileEvent());

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return const ShimmerProfile();
        } else if (state is ProfileLoadedState) {
          final List<Profile> profiles = state.profile;
          final Profile profile = profiles[0];
          String gender = profile
              .pol; // Предположим, что у вас есть переменная profile.pol, которая содержит пол ("M" для мужского, "F" для женского).
          print(gender);
          return ListView(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Positioned(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(120)),
                          child: Image.asset(
                            gender == 'М'
                                ? 'images/man.png'
                                : 'images/child_girl.png',
                            height: 130.h,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 5.w,
                        bottom: 0.h,
                        child: Container(
                          width: 120.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              color: const Color(0xFFFFC107),
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Center(
                            child: Text(
                              profile.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              final AnimationController controller =
                                  AnimationController(
                                duration: const Duration(seconds: 1),
                                vsync: this,
                              );

                              final Animation<double> scaleAnimation =
                                  Tween<double>(begin: 0.5, end: 1.5)
                                      .animate(controller);

                              controller.fling();

                              return AnimatedBuilder(
                                animation: controller,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: scaleAnimation.value,
                                    child: AlertDialog(
                                      backgroundColor: Colors.transparent,
                                      content: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.asset(
                                              'images/card_high.png',
                                              height: 220.h,
                                            ),
                                          ),
                                          Positioned(
                                            left: 120.w,
                                            top: 60.h,
                                            child: SizedBox(
                                              width: 100.w,
                                              height: 100.h,
                                              child: QrImageView(
                                                backgroundColor: Colors.white,
                                                data: profile.qrCode,
                                                version: QrVersions.auto,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );

                              // Ensure there's a return value
                            },
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 20.w, top: 20.h, right: 20.w),
                          alignment: Alignment.centerLeft,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'images/card_high.png',
                              height: 220.h,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 40.h,
                        left: 0.w,
                        right: 20,
                        child: Container(
                          margin: EdgeInsets.only(right: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${profile.name} ${profile.surname}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                              Text(
                                'NFC/RFID/QR/CODE001',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              Text(
                                profile.cardNumber,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              SizedBox(height: 100.h),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Баланс: ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'SF Pro Display',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "${profile.balance} тг",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'SF Pro Display',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    width: double.infinity.w,
                    height: 65.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).Credentials,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontFamily: 'SF Pro Display',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${profile.name} ${profile.surname}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontFamily: 'SF Pro Display',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    width: double.infinity,
                    height: 65.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              S.of(context).ClassOf,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              profile.classInfo,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    width: double.infinity,
                    height: 65.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              S.of(context).ClassTeacher,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              profile.teacherFIO,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  
                  
                ],
              ),
            ],
          );
        } else if (state is ProfileErrorState) {
          Future.delayed(Duration.zero, () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text('Произошла ошибка: ${state.error}'),
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
          return const SizedBox();
        } else {
          return Center(
            child: Text('Unknown state:$state'),
          );
        }
      },
    );
  }
}

class ShimmerProfile extends StatelessWidget {
  const ShimmerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Stack(
            children: [
              Positioned(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: Colors.white),
                  width: 130.w,
                  height: 130.h,
                ),
              ),
              Positioned(
                left: 5.w,
                bottom: 0.h,
                child: Container(
                  width: 120.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                      color: const Color(0xFFFFC107),
                      borderRadius: BorderRadius.circular(10.r)),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                left: 20.w, top: 20.h, right: 20.w, bottom: 20.w),
            height: 220.h,
            width: 400.w,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
          ),
          // Replace with your shimmer loading content for profile data
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20),
                  width: double.infinity, // Adjust width as needed
                  height: 70.h,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
