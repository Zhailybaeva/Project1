import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ok_edus_kz/features/news_screen/news_bloc/news_bloc.dart';
import 'package:ok_edus_kz/features/news_screen/news_bloc/news_event.dart';
import 'package:ok_edus_kz/features/news_screen/news_bloc/news_state.dart';

class NewsScreen extends StatelessWidget {
  final int newsId;
  const NewsScreen({super.key, required this.newsId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc(newsId: newsId),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Жаңалықтар',
            style: TextStyle(
              color: Colors.black,
              fontFamily: "SF Pro Display",
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: ListView(
          children: [
            NewsWidget(
              newsId: newsId,
            ),
          ],
        ),
      ),
    );
  }
}

class NewsWidget extends StatelessWidget {
  final int newsId;
  const NewsWidget({super.key, required this.newsId});

  @override
  Widget build(BuildContext context) {
    final newsBloc = BlocProvider.of<NewsBloc>(context);
    newsBloc.add(FetchNewsEvent());
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NewsLoadedState) {
          final news = state.news;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
                child: Text(
                  news.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  news.date,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF7A7A7A),
                    fontSize: 14,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Image.network(
                  news.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.w, right: 20.w),
                width: double.infinity,
                child: Text(
                  news.text,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              )
            ],
          );
        } else if (state is NewsErrorState) {
          return Center(
            child: Text(state.error),
          );
        } else {
          return Center(
            child: Text('$state'),
          );
        }
      },
    );
  }
}
