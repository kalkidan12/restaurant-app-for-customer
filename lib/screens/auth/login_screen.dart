import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:restaurantappforcustomer/api/config.dart';

import '../../widgets/app_bar_for_auth.dart';
import '../../widgets/custom_container.dart';

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

  loginUser(data) async {
    tokens.clear();
    try {
      var url = Uri.parse(ApiConstants.BASE_URL + ApiConstants.USER_LOGIN);
      var response = await http.post(url, body: data);
      if (response.statusCode == 200) {
        setState(() {
          model = jsonDecode(response.body);
          print(model['access']);
          setState(() {
            usernameErrMsg = "";
            passwordErrMsg = "";
          });
          tokens.setItem('access', model['access']);
          tokens.setItem('refresh', model['refresh']);
        });

        print(model);
        // ignore: use_build_context_synchronously
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const HomePage(),
        //   ),
        // );
      } else {
        // debugPrint(response.body);
        print(jsonDecode(response.body));

        setState(() {
          passwordErrMsg = jsonDecode(response.body)['detail'];
        });
      }
    } catch (e) {
      print(e);
    }
  }

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

            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(50.0), // here the desired height
              child: MyAppbarForAuthPage(),
            ),
            body: Stack(
              children: [
                Container(
                  // height: height / 2 - 50,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/login_banner.jpg"),
                      fit: BoxFit.cover,
                      opacity: 0.7,
                    ),
                  ),
                ),
                Center(
                  child: CustomContainer(
                    padding: const EdgeInsets.all(15),
                    width: width - 50,
                    height: 350,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              margin: const EdgeInsetsDirectional.only(top: 20),
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: TextField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 2, 10, 2),
                                  border: OutlineInputBorder(),
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
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: TextField(
                                obscureText: true,
                                controller: passwordController,
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 2, 10, 2),
                                  border: OutlineInputBorder(),
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
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              height: 35,
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                                child: const Text('Login'),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // register screen
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //         const RegisterScreen(),
                                //   ),
                                // );
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
                )
              ],
            ),
          )),
    );
  }
}
