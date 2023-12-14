import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ok_edus_kz/features/home_screen/bloc/homescreen_bloc.dart';
import 'package:ok_edus_kz/features/home_screen/bloc/homescreen_event.dart';
import 'package:ok_edus_kz/features/home_screen/bloc/homescreen_state.dart';
import 'package:ok_edus_kz/generated/l10n.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /*Color? fontColor;
  int userClass = 0; // Получите userClass из SharedPreference
  List<DateTime> startTimeList = []; // Список для времени начала
  List<DateTime> endTimeList = [];
  List<TimeOfDay> startTimeOfDayList = []; // Declare here
  List<TimeOfDay> endTimeOfDayList = [];

//
  List<int> startMinutesList = []; // Добавьте эту строку
  List<int> endMinutesList = []; // И эту строку
  int currentMinutes = 0; // И эту строку
  int intervalIndex = 0;*/

/*
  Future<void> _fetchData() async {
    try {
      final response = await MainPageService.fetchData();
      print(response.body);

      if (response.statusCode == 200) {
        final apiResponse = ApiResponse.fromJson(json.decode(response.body));

        setState(() {
          infoData = apiResponse.info;
          diaryData = apiResponse.diary;
          newsData = apiResponse.newsList;
        });
        List<DateTime> startTimeList = diaryData
            .map((diary) => DateTime.parse(diary.startTime).toLocal())
            .toList();

        List<DateTime> endTimeList = diaryData
            .map((diary) => DateTime.parse(diary.endTime).toLocal())
            .toList();

        List<TimeOfDay> startTimeOfDayList = startTimeList
            .map((dateTime) => TimeOfDay.fromDateTime(dateTime))
            .toList();

        List<TimeOfDay> endTimeOfDayList = endTimeList
            .map((dateTime) => TimeOfDay.fromDateTime(dateTime))
            .toList();

        List<int> startMinutesList = startTimeOfDayList
            .map((timeOfDay) => timeOfDay.hour * 60 + timeOfDay.minute)
            .toList();

        List<int> endMinutesList = endTimeOfDayList
            .map((timeOfDay) => timeOfDay.hour * 60 + timeOfDay.minute)
            .toList();

        TimeOfDay currentTimeOfDay = TimeOfDay.now();

        int currentMinutes =
            currentTimeOfDay.hour * 60 + currentTimeOfDay.minute;

        for (int i = 0; i < startMinutesList.length; i++) {
          if (currentMinutes >= startMinutesList[i] &&
              currentMinutes <= endMinutesList[i]) {
            intervalIndex = i;
            break;
          }
        }
        int intervalDuration =
            endMinutesList[intervalIndex] - startMinutesList[intervalIndex];
        int progressWithinInterval =
            currentMinutes - startMinutesList[intervalIndex];

        progress = intervalDuration > 0
            ? progressWithinInterval / intervalDuration
            : 0;

        if (intervalIndex >= 0 && intervalIndex < diaryData.length) {
          currentSubject = diaryData[intervalIndex].predmetName;
          currentTeacherName = diaryData[intervalIndex].teacherName;
          currentTeacherSurname = diaryData[intervalIndex].teacherSurname;

          // Format the end time of the current lesson
          DateTime endDateTime = endTimeList[intervalIndex];
          currentLessonEndTime =
              DateFormat('HH:mm').format(endDateTime.toLocal());
        }
      } else {
        // Обработка ошибки, если запрос не успешен
      }
    } catch (error) {
      // Обработка ошибки, если произошла ошибка при запросе
    }
  }
   */

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       
        BlocProvider(
          create: (context) => HomeScreenBloc(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            S.of(context).MainPage,
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
        body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {

                final homeScreenBloc = BlocProvider.of<HomeScreenBloc>(context);
                homeScreenBloc.add(FetchDataEvent()); // Здесь вызываем
                return Future<void>.delayed(const Duration(seconds: 3));
              },
              child: ListView(
                children: const [
                  Column(
                    children: [
                      HomeScreenData(),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class HomeScreenData extends StatelessWidget {
  const HomeScreenData({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime? currentTime;
    currentTime = DateTime.now();
    String? formattedDate;
    formattedDate = DateFormat('dd.MM.yyyy').format(currentTime);

    const progress = 0.6;

    final homeScreenBloc = BlocProvider.of<HomeScreenBloc>(context);
    homeScreenBloc.add(FetchDataEvent());
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        if (state is DataLoadingState) {
          return const ShimmerLoadingList();
        } else if (state is DataLoadedState) {
          //final diaryData = state.diaryData;
          final newsData = state.newsData;
          return Column(
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 80.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.r),
                          bottomRight: Radius.circular(30.r),
                        )),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20.w),
                                  child: Text(
                                    S.of(context).Today,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontFamily: 'SF Pro Display',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  margin: EdgeInsets.only(left: 20.w),
                                  child: Text(
                                    formattedDate ?? 'Error',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.sp,
                                      fontFamily: 'SF Pro Display',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              margin: EdgeInsets.only(right: 20.w),
                              child: Text(
                                "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFF1E1E1E),
                                  fontSize: 20.sp,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.w, bottom: 10.h),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      S.of(context).CurrentLesson,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors
                            .white, // Используйте цвет по умолчанию, если fontColor равен null
                        fontSize: 20.sp,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Stack(children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      width: double.infinity,
                      height: 85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(10.r),
                          value: progress,
                          color: const Color(0xFFFFC107), // Customize the color
                          backgroundColor: const Color(
                              0XFF8FB786), // Customize the background color
                        ),
                      ),
                    ),
                    Positioned(
                        top: 10.h,
                        left: 30.w,
                        child: Text(
                          "Қазақ тілі", // currentSubject
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                    Positioned(
                      left: 30.w,
                      top: 50.h,
                      child: Text(
                        '${S.of(context).Teacher}: '
                        'Аралбаева Арайлым', //
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10.h,
                      right: 30.w,
                      child: Text(
                        S.of(context).Finishing,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Positioned(
                        top: 40.h,
                        right: 30.w,
                        child: Text(
                          "14:00", //currentLessonEndTime
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 26.sp,
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w700,
                          ),
                        ))
                  ]),
                  SizedBox(height: 20.h),
                  Container(
                    margin: EdgeInsets.only(left: 20.w),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      S.of(context).SchoolActivities,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.sp,

                        color: Colors.white, // Испо
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    margin: EdgeInsets.only(left: 10.w),
                    height: 300.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: newsData.length,
                      itemBuilder: (context, index) {
                        final news = newsData[index];
                        return GestureDetector(
                          onTap: () {
                    
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 10.h),
                              width: 320.w,
                              height: 225.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 10.h),
                                    width: 300.w,
                                    height: 140.h,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: Image.network(
                                        news.imageUrl,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 5.h),
                                    child: Text(
                                      news.title.length >
                                              50 // Вы можете изменить это число в зависимости от своих предпочтений
                                          ? '${news.title.substring(0, 50)}...' // Обрезать до определенной длины и добавить многоточие
                                          : news.title,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontFamily: "SF Pro Display",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 5.h),
                                    child: Text(
                                      news.date,
                                      style: TextStyle(
                                          color: const Color(0xFF7A7A7A),
                                          fontSize: 12.sp,
                                          fontFamily: "SF Pro Display",
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 5.h),
                                    child: Text(
                                      S.of(context).ReadMore,
                                      style: TextStyle(
                                          color: const Color(0xFF1E88E5),
                                          fontSize: 12.sp,
                                          fontFamily: "SF Pro Display",
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              )),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.only(left: 20.w, bottom: 10.h),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Следующий урок',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors
                            .white, // Используйте цвет по умолчанию, если fontColor равен null
                        fontSize: 20.sp,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Stack(children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      width: double.infinity,
                      height: 85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(10.r),
                          value: 0.1,
                          color: const Color(0xFFFFC107), // Customize the color
                          backgroundColor: const Color(
                              0XFF8FB786), // Customize the background color
                        ),
                      ),
                    ),
                    Positioned(
                        top: 10.h,
                        left: 30.w,
                        child: Text(
                          "Математика", // currentSubject
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                    Positioned(
                      left: 30.w,
                      top: 50.h,
                      child: Text(
                        '${S.of(context).Teacher}: '
                        'Құрмаш Мейір', //
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10.h,
                      right: 30.w,
                      child: Text(
                        'Начало',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Positioned(
                        top: 40.h,
                        right: 30.w,
                        child: Text(
                          "15:10", //currentLessonEndTime
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 26.sp,
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w700,
                          ),
                        ))
                  ]),
                  SizedBox(height: 20.h),
                ],
              ),
            ],
          );
        } else if (state is DataErrorState) {
          Future.delayed(Duration.zero, () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text('Произошла ошибка: ${state.error}'),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                duration: const Duration(
                    seconds:
                        5), // Установите желаемую продолжительность в секундах
              ),
            );
          });
          return const SizedBox();
        } else {
          return Center(child: Text("$state"));
        }
      },
    );
  }
}



class ShimmerLoadingList extends StatelessWidget {
  const ShimmerLoadingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.r),
                bottomRight: Radius.circular(30.r),
              ),
              color: Colors.white,
            ),
            width: double.infinity,
            height: 80.0.h,
          ),
          SizedBox(height: 20.h),
          Container(
            margin: EdgeInsets.only(left: 20.w, right: 160.w),
            height: 30.h,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,
            ),
            width: double.infinity,
            height: 80.0.h,
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            margin: EdgeInsets.only(left: 20.w, right: 160.h),
            height: 30.h,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 270.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                    left: 20.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.white,
                  ),
                  width: 340.w,
                  height: 270.h,
                );
              },
            ),
          ),
          SizedBox(height: 40.h),
          Container(
            margin: EdgeInsets.only(left: 20.w, right: 160.h),
            height: 30.h,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
          ),
          SizedBox(height: 40.h),
          SizedBox(
            height: 120.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                    left: 20.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.white,
                  ),
                  width: 170.w,
                  height: 120.h,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
