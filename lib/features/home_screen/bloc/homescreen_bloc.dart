import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ok_edus_kz/features/home_screen/bloc/homescreen_event.dart';
import 'package:ok_edus_kz/features/home_screen/bloc/homescreen_state.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ok_edus_kz/model/news_model.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(DataLoadingState()) {
    on<FetchDataEvent>((event, emit) async {
      try {
        QuerySnapshot<Map<String, dynamic>> newsCollection =
            await FirebaseFirestore.instance.collection('news').get();

        // Преобразуем данные из Firestore в объекты NewsModel
        List<NewsModel> newsData = newsCollection.docs.map((doc) {
          Map<String, dynamic> data = doc.data();
          return NewsModel.fromJson(data);
        }).toList();

        emit(DataLoadedState(newsData: newsData)); // Предположим, что DataLoadedState принимает данные для отображения
      } catch (e) {
        emit(DataErrorState('Ошибка при получении данных: $e'));
      }
    });
  }
}
