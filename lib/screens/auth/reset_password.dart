import 'dart:convert';
import 'dart:io';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:restaurantappforcustomer/screens/auth/verify_screen.dart';

import '../../api/config.dart';
import '../../widgets/app_bar_for_auth.dart';
import '../../widgets/custom_container.dart';
import '../home/home_page.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String nameErrMsg = "";
  String locationErrMsg = "";
  String phoneErrMsg = "";
  int user_id = 0;
  bool _isProfileExist = false;
  late Map<String, dynamic> model;

  isIExist() async {}

  bool onReseting = false;
  ResetPasswordUser(data) async {}

  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Container(
        width: width,
        height: height,
        child: Scaffold(
            backgroundColor: Color.fromARGB(255, 235, 235, 235),
            resizeToAvoidBottomInset: false, //new line

            // appBar: const PreferredSize(
            //   preferredSize: Size.fromHeight(50.0), // here the desired height
            //   child: MyAppbarForAuthPage(),
            // ),
            body: Container(
                height: height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/reset_bg.jpg"),
                    fit: BoxFit.cover,
                    opacity: 0.7,
                  ),
                ),
                child: Center(
                  child: CustomContainer(
                    padding: const EdgeInsets.all(20),
                    width: width - 50,
                    height: 200,
                    color: const Color.fromARGB(255, 255, 249, 249),
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Color(0xffeeeeee),
                          blurRadius: 10,
                          offset: Offset(0, 4))
                    ]),
                    borderRadius: BorderRadius.circular(10),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: const Text(
                                'Reset Passssword',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xffeeeeee),
                                        blurRadius: 10,
                                        offset: Offset(0, 4))
                                  ]),
                              margin: const EdgeInsetsDirectional.only(top: 20),
                              child: TextFormField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 235, 235, 235),
                                  prefixIcon: Icon(Icons.email),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 2, 10, 2),
                                  border: InputBorder.none,
                                  labelText: 'Your Email',
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              height: 35,
                              width: 150,
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              VerifyScreen())));
                                },
                                child: onReseting
                                    ? Container(
                                        width: 20,
                                        height: 20,
                                        child: const CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text('Reset'),
                              ),
                            ),
                          ],
                        )),
                  ),
                ))));
  }
}
