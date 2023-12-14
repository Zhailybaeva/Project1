import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ok_edus_kz/features/news_screen/news_bloc/news_event.dart';
import 'package:ok_edus_kz/features/news_screen/news_bloc/news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final int newsId;
  NewsBloc({required this.newsId}) : super(NewsLoadingState()) {
   
  }
}
