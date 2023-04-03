import 'dart:convert';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:restaurantappforcustomer/api/config.dart';
import 'package:restaurantappforcustomer/screens/auth/continue_reg_page.dart';
import 'package:restaurantappforcustomer/screens/auth/login_screen.dart';
import 'package:restaurantappforcustomer/screens/order/menu_order_page.dart';
import 'package:restaurantappforcustomer/screens/order/table_order_list.dart';
import 'package:restaurantappforcustomer/screens/profile/customer_profile_page.dart';
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
          .get(url, headers: {"Authorization": "Bearer " + access_token});
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
        // print(response.body);
        final customerData = await jsonDecode(response.body);
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
    TableOrderList(),
    MenuOrderList(),
    CustomerProfilePage(),
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
      bottomNavigationBar: BottomNavigationBar(
        // configure the appearance and behavior of the bottom navigation bar
        showUnselectedLabels: true,
        selectedFontSize: 16,
        unselectedFontSize: 14,
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Color.fromARGB(255, 104, 104, 104),
        backgroundColor: Colors.white,

        currentIndex: _selectedIndex, // set the current selected index
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        }, // callback function for when an item is tapped
        type: BottomNavigationBarType.fixed,
        // create the list of navigation bar items
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Restaurants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_bar),
            label: 'Tables',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
      ),
    );
  }
}
