// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:baboo_and_co/Components/designs.dart';
import 'package:baboo_and_co/Components/functions.dart';
import 'package:baboo_and_co/details.dart';
import 'package:baboo_and_co/firebase_options.dart';
import 'package:baboo_and_co/upload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Baboo and Co.',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _onAlertButtonsPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Add an Entry",
      desc: "What do you want ?",
      buttons: [
        DialogButton(
          onPressed: () async {
            Navigator.pop(context);
            MyAppComponents.goToPage(
                context: context,
                navigateTo: Upload(
                  title: 'Selling',
                  gridData: await fetchDataFromFirestore(),
                ));
          },
          gradient: LinearGradient(colors: [
            Color.fromRGBO(191, 116, 116, 1),
            Color.fromRGBO(199, 52, 52, 1),
          ]),
          child: Text(
            "SOLD",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        DialogButton(
          onPressed: () async {
            Navigator.pop(context);
            MyAppComponents.goToPage(
                context: context,
                navigateTo: Upload(
                  title: 'Purchasing',
                  gridData: await fetchDataFromFirestore(),
                ));
          },
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0),
          ]),
          child: Text(
            "BUY",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        )
      ],
    ).show();
  }

  Future<List<Map<String, dynamic>>> fetchDataFromFirestore() async {
    Map<String, num> data = {};

    QuerySnapshot millQuerySnapshot =
        await FirebaseFirestore.instance.collection('Mill').get();

    QuerySnapshot shopQuerySnapshot =
        await FirebaseFirestore.instance.collection('Shop').get();

    for (var doc in millQuerySnapshot.docs) {
      String millType = doc['millType'];
      num totalTons = doc['totalTons'];
      data[millType] = (data[millType] ?? 0) + totalTons;
    }

    for (var doc in shopQuerySnapshot.docs) {
      String millType = doc['millType'];
      num totalTons = doc['totalTons'];
      data[millType] = (data[millType] ?? 0) + totalTons;
    }

    List<Map<String, dynamic>> result = [];
    data.forEach((millType, totalTons) {
      result.add({
        'millType': millType,
        'totalTons': totalTons,
      });
    });

    return result;
  }

  String getFormattedDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDateTime = DateFormat('dd-MM').format(dateTime);
    return formattedDateTime;
  }

  StreamSubscription<QuerySnapshot>? _subscription;
  StreamSubscription<QuerySnapshot>? _subscriptionShop;

  num totalOrders = 0;
  num totalOrdersShop = 0;

  void _subscribeToOrders() {
    _subscription = FirebaseFirestore.instance
        .collection('Mill')
        .snapshots()
        .listen((snapshot) {
      num total = 0;

      for (var doc in snapshot.docs) {
        total += doc['totalTons'] ?? 0;
      }

      setState(() {
        totalOrders = total;
      });
    });
  }

  void _subscribeToOrdersShop() {
    _subscriptionShop = FirebaseFirestore.instance
        .collection('Shop')
        .snapshots()
        .listen((snapshot) {
      num total = 0;

      for (var doc in snapshot.docs) {
        total += doc['totalTons'] ?? 0;
      }

      setState(() {
        totalOrdersShop = total;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _subscribeToOrders();
    _subscribeToOrdersShop();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
    _subscriptionShop?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () {
            _onAlertButtonsPressed(context);
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          )),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Mill').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<dynamic> allOrders = [];
              for (var doc in snapshot.data!.docs) {
                List<dynamic> orders = doc['orders'];
                // int totalTons = doc['totalTons'];
                // totalOrders += totalTons;
                allOrders.addAll(orders);
              }
              allOrders.sort((a, b) {
                final dateTimeA = DateTime.parse(a['dateTime']);
                final dateTimeB = DateTime.parse(b['dateTime']);
                return dateTimeB.compareTo(dateTimeA);
              });

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset('assets/shopcard.jpeg'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                MyAppComponents.goToPage(
                                    context: context,
                                    navigateTo: DetailsScreen(
                                      title: 'Mills Details',
                                      isShop: false,
                                      isCustomer: true,
                                    ));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    totalOrders.toString(),
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 50,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 20, left: 5),
                                    child: Text(
                                      'Tons Mills',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: 1,
                          height: 50,
                          color: Colors.amber,
                          child: SizedBox(child: Text('')),
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                MyAppComponents.goToPage(
                                    context: context,
                                    navigateTo: DetailsScreen(
                                      title: 'Shop Details',
                                      isShop: true,
                                      isCustomer: false,
                                    ));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    totalOrdersShop.toString(),
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 50,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 20, left: 5),
                                    child: Text(
                                      'Tons Shop',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Sugar Mill\'s',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    MyAppDesigns.title('Date', 'Dealer', 'Tons', 'Due Rate',
                        'Mill', false, context),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: allOrders.length,
                      itemBuilder: (context, index) {
                        return MyAppDesigns.order(
                            // allOrders[index]['dateTime'],
                            getFormattedDate(allOrders[index]['dateTime']),
                            allOrders[index]['dealer_name'],
                            allOrders[index]['tons'],
                            allOrders[index]['due_price'],
                            allOrders[index]['millType'],
                            allOrders[index]['orderType'] == 'Purchasing'
                                ? true
                                : false,
                            context);
                      },
                    ),
                    const Divider(
                      color: Colors.black12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Shop\'s',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                    MyAppDesigns.title('Date', 'Dealer', 'Tons', 'Due Rate',
                        'Mill', false, context),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Shop')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            List<dynamic> allOrdersShop = [];
                            for (var doc in snapshot.data!.docs) {
                              List<dynamic> orders = doc['orders'];
                              allOrdersShop.addAll(orders);
                            }

                            allOrdersShop.sort((a, b) {
                              final dateTimeA = DateTime.parse(a['dateTime']);
                              final dateTimeB = DateTime.parse(b['dateTime']);
                              return dateTimeB.compareTo(dateTimeA);
                            });

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: allOrdersShop.length,
                              itemBuilder: (context, index) {
                                return MyAppDesigns.order(
                                  getFormattedDate(
                                      allOrdersShop[index]['dateTime']),
                                  allOrdersShop[index]['dealer_name'],
                                  allOrdersShop[index]['tons'],
                                  allOrdersShop[index]['due_price'],
                                  allOrdersShop[index]['millType'],
                                  allOrdersShop[index]['orderType'] ==
                                          'Purchasing'
                                      ? true
                                      : false,
                                  context,
                                );
                              },
                            );
                          }
                        }),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
