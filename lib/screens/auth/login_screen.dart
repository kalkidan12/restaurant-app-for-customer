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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String usernameErrMsg = "";
  String passwordErrMsg = "";
  late Map<String, dynamic> model;
  final LocalStorage tokens = LocalStorage('tokens');

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    passwordController.dispose();
  }

  bool onLogging = false;
  loginUser(data) async {
    tokens.clear();
    try {
      onLogging = true;
      var url = Uri.parse(ApiConstants.BASE_URL + ApiConstants.USER_LOGIN);
      var response = await http.post(url, body: data);
      if (response.statusCode == 200) {
        setState(() {
          model = jsonDecode(response.body);
          // print(model['access']);
          setState(() {
            usernameErrMsg = "";
            passwordErrMsg = "";
          });
          tokens.setItem('access', model['access']);
          tokens.setItem('refresh', model['refresh']);
          onLogging = false;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        });
      } else {
        // debugPrint(response.body);
        // print(jsonDecode(response.body));
        onLogging = false;
        setState(() {
          passwordErrMsg = jsonDecode(response.body)['detail'];
        });
      }
    } catch (e) {
      onLogging = false;
      // print(e);
    }
  }

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

              // appBar: const PreferredSize(
              //   preferredSize: Size.fromHeight(50.0), // here the desired height
              //   child: MyAppbarForAuthPage(),
              // ),
              body: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/bg1.jpg"),
                      fit: BoxFit.cover,
                      opacity: 0.7,
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 234, 148, 82),
                        Color.fromARGB(255, 227, 124, 118),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: CustomContainer(
                      padding: const EdgeInsets.all(20),
                      width: width - 60,
                      height: 320,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
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
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(255, 235, 235, 235),
                                    prefixIcon: Icon(Icons.person),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 2, 10, 2),
                                    border: InputBorder.none,
                                    labelText: 'Username',
                                  ),
                                ),
                              ),
                              Text(
                                usernameErrMsg,
                                style: const TextStyle(
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
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        255, 235, 235, 235),
                                    prefixIcon: Icon(Icons.lock),
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
                                    labelText: 'Password',
                                  ),
                                ),
                              ),
                              Text(
                                passwordErrMsg,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: .8,
                                ),
                              ),
                              const SizedBox(height: 15),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ResetPassword()));
                                },
                                child: const Text(
                                  "Forgote Pasword?",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                width: 150,
                                height: 35,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // print(nameController.text);
                                    // print(passwordController.text);
                                    if (_formKey.currentState!.validate()) {
                                      final username = nameController.text;
                                      final password = passwordController.text;

                                      if (username == '') {
                                        setState(() {
                                          usernameErrMsg =
                                              "Username can not be empty";
                                        });
                                      } else {
                                        setState(() {
                                          usernameErrMsg = "";
                                        });
                                      }
                                      if (password == '') {
                                        setState(() {
                                          passwordErrMsg =
                                              "Password can not be empty";
                                        });
                                      } else {
                                        setState(() {
                                          passwordErrMsg = "";
                                        });
                                      }
                                      if (username != '' && password != '') {
                                        loginUser({
                                          "username": username,
                                          "password": password
                                        });
                                      }

                                      // debugPrint(value1);
                                      // debugPrint(value2);
                                      // do something with the form data
                                    }
                                  },
                                  child: onLogging
                                      ? Container(
                                          width: 20,
                                          height: 20,
                                          child:
                                              const CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Text('Login'),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // register screen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Create new account",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          )),
                    ),
                  )))),
    );
  }
}
