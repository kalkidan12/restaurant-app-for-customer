import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurantappforcustomer/screens/auth/login_screen.dart';
import 'package:restaurantappforcustomer/screens/scanner/scanner_page.dart';

void main() {
  runApp(const MyApp());
  // Handles Status and Nav bar styling/theme
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color.fromARGB(255, 216, 216, 216),
      ),
      home: const LoginScreen(), // QR_Scanner(),
    );
  }
}
