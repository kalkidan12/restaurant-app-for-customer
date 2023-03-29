import 'dart:convert';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:restaurantappforcustomer/api/config.dart';
import 'package:restaurantappforcustomer/screens/auth/continue_reg_page.dart';
import 'package:restaurantappforcustomer/screens/auth/login_screen.dart';
import 'package:restaurantappforcustomer/screens/table/tables_page.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../../widgets/app_bar_for_auth.dart';
import '../restaurant/restaurant_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocalStorage customerProfile = LocalStorage('customer');
  isIExist() async {
    // print("THIS IS RUNNGING:");
    try {
      String access_token = LocalStorage('tokens').getItem('access');
      var url = Uri.parse(ApiConstants.BASE_URL + ApiConstants.USER_PROFILE);
      var response = await http
          .get(url, headers: {"Authorization": "JWT " + access_token});
      if (response.statusCode == 404) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ContinueRegister(),
          ),
        );
        print("Not Created!");
      } else {
        // There is already a profile with this account
        // {
        //     "phone_number": "",
        //     "payment_method": false,
        //     "credit_card_info": ""
        // }
        print(response.body);
        final customerData = jsonDecode(response.body);
        customerProfile.setItem('customer_id', customerData['customer_id']);
        customerProfile.setItem('user_id', customerData['user_id']);
        customerProfile.setItem('phone_number', customerData['phone_number']);
        // customerProfile.setItem(
        //     'payment_method', customerData['payment_method']);
        // customerProfile.setItem(
        //     'credit_card_info', customerData['credit_card_info']);
      }
    } catch (e) {
      print(e);
    }
  }

  final screens = [
    RestaurantList(),
    RestaurantList(),
    RestaurantList(),
    RestaurantList(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    isIExist();
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Center(
        child: screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.white,
        itemCornerRadius: 30,
        containerHeight: 60,
        showElevation: false,
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              icon: Icon(Icons.restaurant),
              title: Text('Restaurants'),
              textAlign: TextAlign.center,
              activeColor: Colors.blueAccent,
              inactiveColor: Colors.blueGrey),
          BottomNavyBarItem(
              icon: Icon(Icons.table_bar),
              title: Text('My Table'),
              textAlign: TextAlign.center,
              activeColor: Colors.blueAccent,
              inactiveColor: Colors.blueGrey),
          BottomNavyBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('My Order'),
              textAlign: TextAlign.center,
              activeColor: Colors.blueAccent,
              inactiveColor: Colors.blueGrey),
          // BottomNavyBarItem(
          //     icon: Icon(Icons.payment),
          //     title: Text('Payment'),
          //     textAlign: TextAlign.center,
          //     activeColor: Colors.blueAccent,
          //     inactiveColor: Colors.grey),
          BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text('Account'),
              textAlign: TextAlign.center,
              activeColor: Colors.blueAccent,
              inactiveColor: Colors.blueGrey)
        ],
      ),
    );
  }
}
