import 'package:flutter/material.dart';
import 'package:restaurantappforcustomer/screens/home/home_page.dart';
import 'package:restaurantappforcustomer/screens/menu/menu_detail.dart';
import 'package:restaurantappforcustomer/screens/restaurant/restaurant_list.dart';

class MenuList extends StatefulWidget {
  const MenuList({super.key});

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(255, 37, 37, 37),
            )),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Restaurant Name',
              style: TextStyle(color: Color.fromARGB(255, 37, 37, 37)),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                '||',
                style: TextStyle(color: Color.fromARGB(255, 37, 37, 37)),
              ),
            ),
            Text(
              'Menu',
              style: TextStyle(color: Color.fromARGB(255, 37, 37, 37)),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20.0,
            left: 5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 12, top: 5, bottom: 5),
                child: const Text(
                  'Catagory One',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    color: Color.fromARGB(255, 97, 97, 97),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 260,
                child: ListView.separated(
                    padding: const EdgeInsets.all(10),
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 20,
                        ),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 200,
                        height: 250,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromARGB(255, 250, 250, 250),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(255, 222, 222, 222),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: Offset(1, 1)),
                          ],
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MenuDetail()));
                                }),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Image.asset(
                                        'assets/images/menu3.png',
                                        width: 120,
                                        height: 120,
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      child: const SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Text(
                                          'Burger & Chips Chips',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: 5,
                                ),
                                height: 40,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        '\$44',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 120, 120, 120),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    IconButton(
                                        padding: EdgeInsets.all(0),
                                        onPressed: () {
                                          print('favorite added');
                                        },
                                        icon: const Icon(
                                          Icons.favorite,
                                          color: Color.fromARGB(
                                              255, 174, 174, 174),
                                          size: 30,
                                        )),
                                  ],
                                ),
                              ),
                            ]),
                      );
                    }),
              ),

              //
              const SizedBox(
                height: 140,
              )
            ],
          ),
        ),
      ),
    );
  }
}
