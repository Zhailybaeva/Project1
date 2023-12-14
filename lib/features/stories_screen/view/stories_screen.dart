import 'package:flutter/material.dart';

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(child: Text('Истории', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),)),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('stories').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child:
                  CircularProgressIndicator(), // Индикатор загрузки, пока данные загружаются
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No stories available'), // Если историй нет
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              // Здесь можешь настраивать отображение каждой истории (document)
              // Например, для каждой истории создай ListTile или Card
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailScreen(imageUrl: document['imageurl']),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: Hero(
                      tag: document[
                          'imageurl'], // Уникальный тег для каждого изображения
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(document['avatar']),
                      ),
                    ),
                    title: Text(document[
                        'username']), // Замени 'title' на поле с заголовком истории
                    subtitle: Text('Добавила историю'),
                    // Добавь еще поля и атрибуты истории в соответствии с твоей базой данных
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}


// Остальной код без изменений

class DetailScreen extends StatefulWidget {
  final String imageUrl;

  const DetailScreen({required this.imageUrl});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Timer _timer;
  int _timeInSeconds = 5;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeInSeconds > 0) {
          _timeInSeconds--;
        } else {
          timer.cancel();
          // По истечении времени переходим на следующий экран
          Navigator.of(context).pop();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar
      (
        backgroundColor: Colors.transparent,
        title: Text('$_timeInSeconds секунд' ),
      ),
      body: Center(
        child: Hero(
          tag: widget.imageUrl,
          child: Image.network(
            widget.imageUrl,
            fit: BoxFit.contain,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel(); // Отменяем таймер при уничтожении экрана
    super.dispose();
  }
}
