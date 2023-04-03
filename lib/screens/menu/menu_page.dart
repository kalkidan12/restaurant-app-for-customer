import 'dart:convert';
import 'package:badges/badges.dart' as badges;

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;

import '../../api/config.dart';
import '../../model/menu_model.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/darwer_widget.dart';

class MenuPage extends StatefulWidget {
  final int restaurantId;
  final int bookedTableId;
  const MenuPage({required this.restaurantId, required this.bookedTableId});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  bool _isLoading = false;
  // List checkV = List.empty(growable: true);
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
    // checkV.toList();
    readJSon();
  }

  int _cartBadgeAmount = 3;
  late bool _showCartBadge;
  Color color = Colors.red;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    _showCartBadge = _cartBadgeAmount > 0;

    return Scaffold(
      // drawer: const DrawerWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Text("Order"),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110.0), // here the desired height
        child: MyAppbar(
          actions: [
            Container(
                margin: EdgeInsets.only(right: 10),
                child: _shoppingCartBadge()),
          ],
          appbarTitle: 'Menu',
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                width: MediaQuery.of(context).size.width - 50,
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  // controller: nameController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 240, 240, 240),
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                        ),
                        color: const Color.fromARGB(255, 1, 101, 183),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                      border: InputBorder.none,
                      hintText: 'search menu foods',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 1, 101, 183))),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(
                8 * screenWidth / 100, 20, 7 * screenWidth / 100, 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  RefreshIndicator(
                    onRefresh: () async {
                      if (!_isLoading) {
                        // check if an API request is not already in progress
                        setState(() {
                          _isLoading =
                              true; // set the flag to true before starting the API request
                        });
                        await readJSon();
                        setState(() {
                          _isLoading =
                              false; // set the flag to false after the API request is completed
                        });
                      }
                    },
                    child: Container(
                        height: MediaQuery.of(context).size.height - 200,
                        child: FutureBuilder<List<MenuModel>>(
                          future: readJSon(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<MenuModel> menus = snapshot.data!;
                              return ListView.builder(
                                  itemCount: menus.length,
                                  itemBuilder: (context, index) {
                                    // checkV.addAll({index: false});
                                    // final mycheck = <int, bool>{index: false};
                                    // checkV.addEntries(mycheck.entries);
                                    // checkV.add(false);
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 241, 241, 241),
                                        boxShadow: List.filled(
                                          3,
                                          const BoxShadow(
                                            blurRadius: 4,
                                            blurStyle: BlurStyle.outer,
                                            color: Colors.black12,
                                          ),
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            color: const Color.fromARGB(
                                                255, 234, 234, 234),
                                            padding: const EdgeInsets.all(10),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(50),
                                              ),
                                              child: Image.asset(
                                                'assets/images/menu1.png',
                                                fit: BoxFit.contain,
                                                width: 100.0,
                                                height: 100.0,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 120,
                                            // width: MediaQuery.of(context).size.width - 174,
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            decoration: const BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 243, 243, 243),
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      menus[index].name,
                                                      style: const TextStyle(
                                                          fontSize: 22.0,
                                                          color:
                                                              Color(0xFF000000),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              "Merriweather"),
                                                    ),
                                                    // SizedBox(height: 10,),
                                                    SizedBox(
                                                      width: 110,
                                                      child: Text(
                                                        menus[index]
                                                            .description,
                                                        softWrap: true,
                                                        style: const TextStyle(
                                                            fontSize: 15.0,
                                                            color: Color(
                                                                0xFF000000),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                "Merriweather"),
                                                      ),
                                                    ),
                                                    Text(
                                                      menus[index]
                                                          .price
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 20.0,
                                                          color:
                                                              Color(0xFF000000),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              "Merriweather"),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Checkbox(
                                                      value: false,
                                                      key: ValueKey(
                                                          menus[index].dishId),
                                                      onChanged: (value) {
                                                        value = value;
                                                      },
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            } else {
                              return Center(
                                  child: Container(
                                      width: 40,
                                      height: 40,
                                      child:
                                          const CircularProgressIndicator()));
                            }
                          },
                        )),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  Widget _shoppingCartBadge() {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 0, end: 3),
      badgeAnimation: badges.BadgeAnimation.slide(
          // disappearanceFadeAnimationDuration: Duration(milliseconds: 200),
          // curve: Curves.easeInCubic,
          ),
      showBadge: _showCartBadge,
      badgeStyle: badges.BadgeStyle(
        badgeColor: color,
      ),
      badgeContent: Text(
        _cartBadgeAmount.toString(),
        style: TextStyle(color: Colors.white),
      ),
      child: IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
    );
  }
}
