import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:restaurantappforcustomer/api/config.dart';
import 'package:restaurantappforcustomer/screens/auth/continue_reg_page.dart';
import 'package:restaurantappforcustomer/screens/auth/login_screen.dart';

import '../../widgets/app_bar_for_auth.dart';

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
            builder: (context) => const ContinueREgister(),
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
        // final customerData = jsonDecode(response.body);
        // customerProfile.setItem('customer_id', customerData['customer_id']);
        // customerProfile.setItem('user_id', customerData['user_id']);
        // customerProfile.setItem('phone_number', customerData['phone_number']);
        // customerProfile.setItem(
        //     'payment_method', customerData['payment_method']);
        // customerProfile.setItem(
        //     'credit_card_info', customerData['credit_card_info']);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    isIExist();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 235, 235),
      resizeToAvoidBottomInset: false, //new line

      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50.0), // here the desired height
        child: MyAppbarForAuthPage(),
      ),
      body: Container(
        child: Text("Hello"),
      ),
    );
  }
}
