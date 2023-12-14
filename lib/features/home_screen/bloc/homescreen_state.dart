import 'package:ok_edus_kz/model/news_model.dart';

abstract class HomeScreenState {}

class DataLoadingState extends HomeScreenState {}

class DataLoadedState extends HomeScreenState {

  final List<NewsModel> newsData;

  DataLoadedState({
  
    required this.newsData,
  });
}

class DataErrorState extends HomeScreenState {
  final String error;

  DataErrorState(this.error);
}