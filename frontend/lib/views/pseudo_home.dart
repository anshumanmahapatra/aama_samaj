import 'package:aama_samaj_temp_frontend/views/add_post.dart';
import 'package:aama_samaj_temp_frontend/views/leaderboard.dart';
import 'package:aama_samaj_temp_frontend/views/progress_screen.dart';
import 'package:aama_samaj_temp_frontend/views/notice.dart';

import '../views/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../views/login.dart';

class PseudoHome extends StatelessWidget {
  const PseudoHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    Login login = Get.put(const Login());
    Home home = Get.put(const Home());
    double height = Get.mediaQuery.size.height;
    double width = Get.mediaQuery.size.width;
    return FutureBuilder<bool>(
        future: authController.isUserLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            debugPrint(snapshot.data.toString());
            if (snapshot.data == true) {
              return const MyStatefulWidget();
            } else {
              return login;
            }
          } else if (snapshot.hasError) {
            return SizedBox(
                height: height,
                width: width,
                child: Center(
                  child: Text(snapshot.error.toString()),
                ));
          } else {
            return SizedBox(
                height: height,
                width: width,
                child: const Center(
                  child: CircularProgressIndicator(),
                ));
          }
        });
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const List _widgetOptions = [
    Home(),
    Notice(),
    AddPost(),
    ProgressScreen(),
    Leaderboard(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Quiz',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Post',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timelapse),
            label: 'Progress',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Leaderboard',
            backgroundColor: Colors.purple,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
