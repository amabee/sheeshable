import 'package:flutter/material.dart';
import 'package:sheeshable/pages/home.dart';
import 'package:sheeshable/pages/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Widget> _childrenPage = [
    Home(),
    SearchPage(),
    Center(
      child: Text("New Post"),
    ),
    Center(
      child: Text("Reels"),
    ),
    Center(
      child: Text("Profile"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    void _bottomNavTap(int index) {
      setState(() {
        selectedIndex = index;
      });
    }

    return Scaffold(
      body: _childrenPage[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.lightBlue,
        onTap: _bottomNavTap,
        type: BottomNavigationBarType.fixed,
        iconSize: 28,
        items: [
          BottomNavigationBarItem(
            icon: InkResponse(
              onTap: () => _bottomNavTap(0),
              child: Icon(Icons.home_filled),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: InkResponse(
              onTap: () => _bottomNavTap(1),
              child: Icon(Icons.search),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: InkResponse(
              onTap: () => _bottomNavTap(2),
              child: Icon(Icons.add_box_outlined),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: InkResponse(
              onTap: () => _bottomNavTap(3),
              child: Icon(Icons.video_call),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: InkResponse(
              onTap: () => _bottomNavTap(4),
              child: Icon(Icons.person),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
