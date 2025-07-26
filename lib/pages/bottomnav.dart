import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:movie_booking_app/pages/booking.dart';
import 'package:movie_booking_app/pages/home.dart';
import 'package:movie_booking_app/pages/profile.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late List<Widget> pages;
  late HomePage home;
  late Booking booking;
  late Profile profile;
  int currentTabIndex = 0;
  @override
  void initState() {
    home = HomePage();
    booking = Booking();
    profile = Profile();
    pages = [home, booking, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.black,
        color: const Color.fromARGB(255, 204, 151, 7),
        animationDuration: Duration(microseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: const [
          Icon(Icons.home, size: 30, color: Colors.black),
          Icon(Icons.book, size: 30, color: Colors.black),
          Icon(Icons.person, size: 30, color: Colors.black),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
