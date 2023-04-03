import 'dart:convert';
import 'dart:io';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

import '../../api/config.dart';
import '../../widgets/app_bar_for_auth.dart';
import '../../widgets/custom_container.dart';
import '../home/home_page.dart';

class ContinueRegister extends StatefulWidget {
  const ContinueRegister({super.key});

  @override
  State<ContinueRegister> createState() => _ContinueRegisterState();
}

class _ContinueRegisterState extends State<ContinueRegister> {
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

  isIExist() async {
    // print("THIS IS RUNNGING:");
    try {
      String access_token = LocalStorage('tokens').getItem('access');
      var url = Uri.parse(ApiConstants.BASE_URL + ApiConstants.USER_ACCOUNT);
      var response = await http
          .get(url, headers: {"Authorization": "Bearer " + access_token});
      if (response.statusCode == 200) {
        return true;
      } else {
        // There is already a profile with this account
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  isProfileExist() async {
    // print("THIS IS RUNNGING:");
    try {
      String access_token = LocalStorage('tokens').getItem('access');
      var url = Uri.parse(ApiConstants.BASE_URL + ApiConstants.USER_PROFILE);
      var response = await http
          .get(url, headers: {"Authorization": "Bearer " + access_token});
      if (response.statusCode == 404) {
        setState(() {
          _isProfileExist = false;
        });
      } else {
        // There is already a profile with this account
        setState(() {
          _isProfileExist = true;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _isProfileExist = false;
      });
    }
  }

  bool onRedirecting = false;
  ContinueRegisterUser(data) async {
    // print(data);
    try {
      onRedirecting = true;
      var url =
          Uri.parse(ApiConstants.BASE_URL + ApiConstants.CUSTOMER_REGISTER);
      String access_token = LocalStorage('tokens').getItem('access');
      var response = await http.post(url,
          body: data, headers: {"Authorization": "Bearer " + access_token});
      // print(response.statusCode);
      if (response.statusCode == 201) {
        onRedirecting = false;
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const HomePage(),
        //   ),
        // );
      } else {
        // print(jsonDecode(response.body));
        onRedirecting = false;

        // setState(() {
        //   nameErrMsg = (jsonDecode(response.body)['name'] != null)
        //       ? jsonDecode(response.body)['name'][0]
        //       : "";
        //   locationErrMsg = (jsonDecode(response.body)['location'] != null)
        //       ? jsonDecode(response.body)['location'][0]
        //       : "";
        // phoneErrMsg = (jsonDecode(response.body)['phone_number'] != null)
        //     ? jsonDecode(response.body)['phone_number'][0]
        //     : "";
        //   // passwordErrMsg = (jsonDecode(response.body)['user_type'] != null)
        //   //     ? jsonDecode(response.body)['user_type'][0]
        //   //     : "";
        // });
      }
    } catch (e) {
      onRedirecting = false;
      // print(e);
    }
  }

  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'DE';
  PhoneNumber number = PhoneNumber(isoCode: 'DE');

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
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 232, 192, 239),
                      Color.fromARGB(255, 185, 222, 237),
                    ],
                  ),
                  // image: DecorationImage(
                  //   image: AssetImage("assets/images/bg2.jpg"),
                  //   fit: BoxFit.cover,
                  //   opacity: 0.7,
                  // ),
                ),
                child: Center(
                  child: CustomContainer(
                    padding: const EdgeInsets.all(15),
                    width: width - 50,
                    height: 250,
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
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              child: const Text(
                                'Continue registration',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0xffeeeeee),
                                          blurRadius: 10,
                                          offset: Offset(0, 4))
                                    ]),
                                child: InternationalPhoneNumberInput(
                                  autoFocus: true,
                                  onInputChanged: (PhoneNumber number) {
                                    setState(() {
                                      this.number = number;
                                    });
                                  },
                                  errorMessage: 'Invalid phone number',
                                  onInputValidated: (bool value) {},
                                  selectorConfig: const SelectorConfig(
                                    selectorType:
                                        PhoneInputSelectorType.BOTTOM_SHEET,
                                  ),
                                  ignoreBlank: false,
                                  autoValidateMode: AutovalidateMode.disabled,
                                  selectorTextStyle:
                                      const TextStyle(color: Colors.black),
                                  initialValue: null,
                                  textFieldController: controller,
                                  formatInput: true,
                                  keyboardType: TextInputType.phone,
                                  inputBorder: InputBorder.none,
                                  onSaved: (PhoneNumber number) {
                                    setState(() {
                                      this.number = number;
                                    });
                                  },
                                )),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              height: 35,
                              width: 150,
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    final phone = number.phoneNumber;

                                    if (phone == '') {
                                      setState(() {
                                        phoneErrMsg =
                                            "Phone number can not be empty";
                                      });
                                    } else {
                                      setState(() {
                                        phoneErrMsg = "";
                                      });
                                    }

                                    // print(_isProfileExist);
                                    isProfileExist();

                                    if (_isProfileExist) {
                                      setState(() {
                                        phoneErrMsg =
                                            "you already created your account.";

                                        sleep(const Duration(seconds: 3));
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage(),
                                          ),
                                        );
                                      });
                                    } else {
                                      if (phone != '') {
                                        ContinueRegisterUser({
                                          "phone_number": phone.toString(),
                                          "payment_method": "false",
                                          "credit_card_info": "111-111-111-111"
                                        });
                                      }
                                    }
                                  }
                                },
                                child: onRedirecting
                                    ? Container(
                                        width: 20,
                                        height: 20,
                                        child: const CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text('Submit'),
                              ),
                            ),
                          ],
                        )),
                  ),
                ))));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
