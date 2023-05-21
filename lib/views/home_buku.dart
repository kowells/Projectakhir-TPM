import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grafimedia/views/konversi.dart';
import 'package:grafimedia/views/menu_buku.dart';
import 'package:grafimedia/views/profile_users.dart';
import 'package:grafimedia/views/waktu.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    ProfilePage(),
    HomePage(),
    KonversiPage(),
    Waktu()

  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_sharp),
            label: 'Books Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money_outlined),
            label: 'Konversi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timelapse),
            label: 'Waktu',
          ),

        ],
      ),
    );
  }
}
