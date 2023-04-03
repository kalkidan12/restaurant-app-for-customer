import 'dart:io';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter/material.dart';
import 'package:restaurantappforcustomer/screens/auth/set_password.dart';
import '../../widgets/custom_container.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});
  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
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
  VerifyScreenUser(data) async {}

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
                ),
                child: Center(
                  child: CustomContainer(
                    padding: const EdgeInsets.all(20),
                    width: width - 50,
                    height: 220,
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
                                'Verify code',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsetsDirectional.only(top: 20),
                              child: OtpTextField(
                                numberOfFields: 5,
                                borderColor: Colors.orange,
                                //set to true to show as box or false to show as dash
                                showFieldAsBox: true,
                                //runs when a code is typed in
                                onCodeChanged: (String code) {
                                  //handle validation or checks here
                                },
                                //runs when every textfield is filled
                                onSubmit: (String verificationCode) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Verification Code"),
                                          content: Text(
                                              'Code entered is $verificationCode'),
                                        );
                                      });
                                  // sleep(Duration(seconds: 5));
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             SetNewPassword()));
                                }, // end onSubmit
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
                                          builder: (context) =>
                                              SetNewPassword()));
                                },
                                child: onReseting
                                    ? Container(
                                        width: 20,
                                        height: 20,
                                        child: const CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text('Verify'),
                              ),
                            ),
                          ],
                        )),
                  ),
                ))));
  }
}
