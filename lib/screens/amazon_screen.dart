
import 'package:flutter/material.dart';
import 'package:task33_complete_from_my_frien/screens/home_screen.dart';
import 'package:task33_complete_from_my_frien/screens/profile_screen.dart';
class AmazonScreen extends StatefulWidget {
  const AmazonScreen({super.key});
  @override
  State<AmazonScreen> createState() => _AmazonScreenState();
}
class _AmazonScreenState extends State<AmazonScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const SizedBox(),
    const ProfileScreen(),
  ];
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            label: 'search',
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person_outlined),
          ),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}