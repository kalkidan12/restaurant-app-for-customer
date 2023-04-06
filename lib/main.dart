import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurantappforcustomer/screens/auth/continue_reg_page.dart';
import 'package:restaurantappforcustomer/screens/auth/login_screen.dart';
import 'package:restaurantappforcustomer/screens/menu/menu_list.dart';

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
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.lightBlue,
        ),
      ),
      home: LoginScreen(), //MenuList(), , //ContinueRegister(),
    );
  }
}

//
