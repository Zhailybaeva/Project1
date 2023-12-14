import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:ok_edus_kz/features/home_screen/homescreen.dart';
import 'package:ok_edus_kz/features/stories_screen/view/stories_screen.dart';
import 'package:ok_edus_kz/features/profile_screen/view/profile_screen.dart';
import 'package:ok_edus_kz/features/school_screen/school_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final CircularBottomNavigationController _navigationController =
      CircularBottomNavigationController(0);

  final List<TabItem> tabItems = List.of([
    TabItem(Icons.home, "Басты бет", const Color(0xFFFFC107),
        labelStyle: const TextStyle(fontWeight: FontWeight.normal)),
    TabItem(Icons.school, "Мектеп", const Color(0xFFFFC107),
        labelStyle: const TextStyle(color: Color(0xFFFFC107), fontWeight: FontWeight.normal)),
    TabItem(Icons.chat_bubble, "Чат", const Color(0xFFFFC107),
        circleStrokeColor: Colors.black),
    TabItem(Icons.man, "Профиль", Colors.yellow),
  ]);

  void _onItemTapped(int? index) {
    setState(() {
      _selectedIndex = index ?? 0; // Set a default value if index is null
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreen = HomeScreen();

    switch (_selectedIndex) {
      case 0:
        currentScreen = HomeScreen();
        break;
      case 1:
        currentScreen = SchoolScreen();
        break;
      case 2:
        currentScreen = StoriesScreen();
        break;
      case 3:
        currentScreen = ProfileScreen();
        break;
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        backgroundColor: Colors.transparent,
      
        body: currentScreen,
        bottomNavigationBar: CircularBottomNavigation(
          tabItems,
          selectedCallback: (dynamic selectedPos) {
            if (selectedPos != null) {
              _onItemTapped(selectedPos as int);
            }
          },
          controller: _navigationController,
        ),
      ),
    );
  }
}
