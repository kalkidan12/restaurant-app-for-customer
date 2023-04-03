import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:restaurantappforcustomer/api/config.dart';
import 'package:restaurantappforcustomer/screens/auth/register_page.dart';
import 'package:restaurantappforcustomer/screens/auth/reset_password.dart';

import '../../widgets/app_bar_for_auth.dart';
import '../../widgets/custom_container.dart';
import '../home/home_page.dart';

class SetNewPassword extends StatefulWidget {
  const SetNewPassword({super.key});

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  final _formKey = GlobalKey<FormState>();

  late Map<String, dynamic> model;
  final LocalStorage tokens = LocalStorage('tokens');

  @override
  void dispose() {
    super.dispose();
  }

  bool changing = false;
  resetPassword(data) async {}

  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    return Form(
      child: SizedBox(
          width: width,
          height: height,
          child: Scaffold(
              backgroundColor: const Color.fromARGB(255, 235, 235, 235),
              resizeToAvoidBottomInset: false, //new line

              body: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 232, 192, 239),
                        Color.fromARGB(255, 185, 222, 237),
                      ],
                    ),
                  ),
                  child: Center(
                    child: CustomContainer(
                      padding: const EdgeInsets.all(20),
                      width: width - 60,
                      height: 280,
                      color: Color.fromARGB(255, 255, 249, 249),
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
                                  'Update Passssword',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
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
                                margin:
                                    const EdgeInsetsDirectional.only(top: 20),
                                child: TextFormField(
                                  obscuringCharacter: '*',
                                  obscureText: showPassword ? false : true,
                                  // controller: passwordController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        255, 235, 235, 235),
                                    prefixIcon: const Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            showPassword = !showPassword;
                                          });
                                        },
                                        icon: Icon(
                                          showPassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        )),
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(10, 2, 10, 2),
                                    border: InputBorder.none,
                                    labelText: 'New Password',
                                  ),
                                ),
                              ),
                              const Text(
                                '',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: .8,
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
                                margin:
                                    const EdgeInsetsDirectional.only(top: 5),
                                child: TextFormField(
                                  obscuringCharacter: '*',
                                  obscureText: showPassword ? false : true,
                                  // controller: rePasswordController,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(255, 235, 235, 235),
                                    prefixIcon: Icon(Icons.lock),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 2, 10, 2),
                                    border: InputBorder.none,
                                    labelText: 'Re-Password',
                                  ),
                                ),
                              ),
                              const Text(
                                '',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: .8,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                width: 150,
                                height: 35,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: changing
                                      ? Container(
                                          width: 20,
                                          height: 20,
                                          child:
                                              const CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Text('Submit'),
                                ),
                              ),
                            ],
                          )),
                    ),
                  )))),
    );
  }
}
