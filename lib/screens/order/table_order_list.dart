import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:restaurantappforcustomer/api/config.dart';
import 'package:restaurantappforcustomer/model/menu_model.dart';
import 'menu_order_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' as rootBundle;

import '../../widgets/app_bar.dart';
import '../../widgets/darwer_widget.dart';

class TableOrderList extends StatefulWidget {
  const TableOrderList({super.key});

  @override
  State<TableOrderList> createState() => _TableOrderListState();
}

class _TableOrderListState extends State<TableOrderList> {
  bool _isLoading = false;
  Future<List<MenuModel>> readJSon() async {
    try {
      String access_token = LocalStorage('tokens').getItem('access');
      var url = Uri.parse(ApiConstants.BASE_URL + ApiConstants.MENUS);
      var response = await http
          .get(url, headers: {"Authorization": "Bearer " + access_token});
      if (response.statusCode == 200) {
        List mapedData = json.decode(response.body) as List<dynamic>;
        List<MenuModel> menus =
            mapedData.map((menu) => MenuModel.fromJson(menu)).toList();
        // print(menus);
        // setState(() {
        //   _isLoading = true;
        // });
        return menus;
      } else {
        // There is already a profile with this account
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    readJSon();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // here the desired height
        child: MyAppbar(
          appbarTitle: 'Booked Tables',
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(
            8 * screenWidth / 100, 20, 7 * screenWidth / 100, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Tables",
                  style: TextStyle(
                      fontSize: 28.0,
                      color: Color.fromARGB(255, 90, 86, 97),
                      fontWeight: FontWeight.w300,
                      fontFamily: "Merriweather"),
                ),
                Icon(
                  Icons.add,
                  color: const Color(0xFF736c6c),
                  size: 36.0,
                ),
              ],
            ),
            const Divider(
              color: Colors.black87,
            ),
            const SizedBox(height: 10),
            Container(
                height: MediaQuery.of(context).size.height - 200,
                child: FutureBuilder<List<MenuModel>>(
                  future: readJSon(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<MenuModel> menus = snapshot.data!;
                      return ListView.builder(
                          itemCount: menus.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 25),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 232, 248, 255),
                                boxShadow: List.filled(
                                  3,
                                  const BoxShadow(
                                    blurRadius: 2,
                                    blurStyle: BlurStyle.outer,
                                    color: Color.fromARGB(31, 0, 52, 223),
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Expanded(
                                          child: Text(
                                            '',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            '3/30/2023',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(3),
                                      color: Color.fromARGB(255, 139, 180, 251),
                                      width: double.infinity,
                                      height: 3,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Expanded(
                                          child: Text(
                                            'Restuarant Name',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'ABC Reataurant',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(3),
                                      color: Color.fromARGB(255, 139, 180, 251),
                                      width: double.infinity,
                                      height: 3,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Table ID',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            child: Container(
                                                width: double.infinity,
                                                child: ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: 2,
                                                    itemBuilder:
                                                        ((context, index) =>
                                                            Row(
                                                              children: const [
                                                                Expanded(
                                                                  child: Text(
                                                                    'Table ID',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                ),
                                                              ],
                                                            )))),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(3),
                                      color: Color.fromARGB(255, 139, 180, 251),
                                      width: double.infinity,
                                      height: 3,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Expanded(
                                          child: Text(
                                            'Order_status',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Placed',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(3),
                                      color: Color.fromARGB(255, 139, 180, 251),
                                      width: double.infinity,
                                      height: 3,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Expanded(
                                          child: Text(
                                            'Total Price',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            '\$233',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(3),
                                      color: Color.fromARGB(255, 139, 180, 251),
                                      width: double.infinity,
                                      height: 3,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return Center(
                          child: Container(
                              width: 40,
                              height: 40,
                              child: const CircularProgressIndicator()));
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
