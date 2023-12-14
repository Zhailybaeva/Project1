import 'package:equatable/equatable.dart';
import 'package:ok_edus_kz/model/news_model.dart';


abstract class NewsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewsInitialState extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadedState extends NewsState {
  final NewsModel news;

  NewsLoadedState({required this.news});


  @override
  List<Object?> get props => [];
}

class NewsErrorState extends NewsState {
  final String error;

  NewsErrorState(this.error);

  @override
  List<Object?> get props => [error];
}