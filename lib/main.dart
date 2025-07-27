import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/pages/booking.dart';
import 'package:movie_booking_app/pages/detail_page.dart';
import 'package:movie_booking_app/pages/forgot_password.dart';
import 'package:movie_booking_app/pages/login.dart';
import 'package:movie_booking_app/pages/bottomnav.dart';
import 'package:movie_booking_app/pages/home.dart';
import 'package:movie_booking_app/pages/signup.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:movie_booking_app/service/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishedkey;
  await Stripe.instance.applySettings();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState(); // ✅ correct
}

class _MyAppState extends State<MyApp> {
  // ✅ correct
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage());
  }
}
