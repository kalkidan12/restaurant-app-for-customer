import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:restaurantappforcustomer/api/config.dart';

import '../../widgets/app_bar_for_auth.dart';
import '../../widgets/custom_container.dart';
import 'continue_reg_page.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String usernameErrMsg = "";
  String emailErrMsg = "";
  String passwordErrMsg = "";
  String user_type = 'C';
  late Map<String, dynamic> model;
  final LocalStorage tokens = LocalStorage('tokens');

  registerUser(data) async {
    try {
      var url = Uri.parse(ApiConstants.BASE_URL + ApiConstants.USER_REGISTER);
      var response = await http.post(url, body: data);
      loginUser(data['username'], data['password']);
      if (response.statusCode == 201) {
        setState(() {
          this.model = jsonDecode(response.body);
          print("USER_ID : ${model['id']}");
          setState(() {
            usernameErrMsg = "";
            emailErrMsg = "";
            passwordErrMsg = "";
          });

          // loginUser(data['username'], data['password']);
          loginUser(model['username'], model['password']);
        });
      } else {
        // print(jsonDecode(response.body)['password'][0]);

        setState(() {
          usernameErrMsg = (jsonDecode(response.body)['username'] != null)
              ? jsonDecode(response.body)['username'][0]
              : "";
          emailErrMsg = (jsonDecode(response.body)['email'] != null)
              ? jsonDecode(response.body)['email'][0]
              : "";
          passwordErrMsg = (jsonDecode(response.body)['password'] != null)
              ? jsonDecode(response.body)['password'][0]
              : "";
          // passwordErrMsg = (jsonDecode(response.body)['user_type'] != null)
          //     ? jsonDecode(response.body)['user_type'][0]
          //     : "";
        });
      }
    } catch (e) {
      print(e);
    }
  }

  loginUser(String username, String password) async {
    tokens.clear();
    var data = {"username": username, "password": password};
    try {
      var url = Uri.parse(ApiConstants.BASE_URL + ApiConstants.USER_LOGIN);
      var response = await http.post(url, body: data);
      if (response.statusCode == 200) {
        setState(() {
          Map<String, dynamic> model = jsonDecode(response.body);

          tokens.setItem('access', model['access']);
          tokens.setItem('refresh', model['refresh']);

          print("LOGIN SUCCESS : ${model['access']}");
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ContinueRegister(),
          ),
        );
      } else {
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

    return Container(
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
                height: height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/register_banner.jpg"),
                    fit: BoxFit.cover,
                    opacity: 0.7,
                  ),
                ),
                child: null /* add child content here */,
              ),
              Center(
                child: CustomContainer(
                  padding: const EdgeInsets.all(15),
                  width: width - 50,
                  height: 450,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Register',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: const EdgeInsetsDirectional.only(top: 20),
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 2, 10, 2),
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                              ),
                            ),
                          ),
                          Text(
                            emailErrMsg,
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
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final username = nameController.text;
                                  final email = emailController.text;
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

                                  if (email == '') {
                                    setState(() {
                                      emailErrMsg = "Emails can not be empty";
                                    });
                                  } else {
                                    setState(() {
                                      emailErrMsg = "";
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
                                  if (username != '' &&
                                      email != '' &&
                                      password != '') {
                                    registerUser({
                                      "username": username,
                                      "email": email,
                                      "password": password,
                                      "user_type": user_type,
                                    });
                                  }
                                }
                              },
                              child: const Text(
                                'Register',
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text("Already have an account?"),
                              TextButton(
                                onPressed: () {
                                  // already have an account
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 18,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              )
            ],
          ),
        ));
  }
}
