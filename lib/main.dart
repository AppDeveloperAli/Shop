// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';
import 'package:baboo_and_co/Components/designs.dart';
import 'package:baboo_and_co/Components/functions.dart';
import 'package:baboo_and_co/Widgets/snackBar.dart';
import 'package:baboo_and_co/firebase_options.dart';
import 'package:baboo_and_co/ledger.dart';
import 'package:baboo_and_co/upload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
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

  List<Map<String, dynamic>> gridData = [];

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

  List<Map<String, dynamic>> gridDataBroker = [];

  Future<List<Map<String, dynamic>>> fetchDataFromFirestoreBroker() async {
    Map<String, num> brokerData = {};

    // Fetch data from 'Collection1' collection
    QuerySnapshot collection1QuerySnapshot =
        await FirebaseFirestore.instance.collection('Shop').get();

    // Iterate through documents in 'Collection1' collection
    for (var doc1 in collection1QuerySnapshot.docs) {
      List<dynamic> orders = doc1['orders'];
      // Iterate through orders array in each document
      for (var order in orders) {
        String brokerName =
            order['brokerName'].toLowerCase(); // Convert to lowercase
        brokerName = brokerName.substring(0, 1).toUpperCase() +
            brokerName.substring(1); // Capitalize first letter
        num brokerHaveTons = num.tryParse(order['brokerHaveTons']) ?? 0;
        brokerData[brokerName] = (brokerData[brokerName] ?? 0) + brokerHaveTons;
      }
    }

    // Fetch data from 'Collection2' collection
    QuerySnapshot collection2QuerySnapshot =
        await FirebaseFirestore.instance.collection('Mill').get();

    // Iterate through documents in 'Collection2' collection
    for (var doc2 in collection2QuerySnapshot.docs) {
      List<dynamic> orders = doc2['orders'];
      // Iterate through orders array in each document
      for (var order in orders) {
        String brokerName =
            order['brokerName'].toLowerCase(); // Convert to lowercase
        brokerName = brokerName.substring(0, 1).toUpperCase() +
            brokerName.substring(1); // Capitalize first letter
        num brokerHaveTons = num.tryParse(order['brokerHaveTons']) ?? 0;
        brokerData[brokerName] = (brokerData[brokerName] ?? 0) + brokerHaveTons;
      }
    }

    // Convert aggregated data into the desired format
    List<Map<String, dynamic>> result = [];
    brokerData.forEach((brokerName, totalTons) {
      result.add({
        'brokerName': brokerName,
        'totalTons': totalTons,
      });
    });

    return result;
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
    fetchOrdersFromFirestore();
    fetchDataFromFirestore().then((data) {
      setState(() {
        gridData = data;
      });
    });
    fetchDataFromFirestoreBroker().then((data) {
      setState(() {
        gridDataBroker = data;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
    _subscriptionShop?.cancel();
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<dynamic> filteredOrders = [];

  Future<List<dynamic>> fetchOrdersFromFirestore() async {
    // Fetch data from 'Mill' collection
    QuerySnapshot millQuerySnapshot =
        await FirebaseFirestore.instance.collection('Mill').get();

    // Iterate through documents in 'Mill' collection
    for (var doc in millQuerySnapshot.docs) {
      List<dynamic> orders = doc['orders'];
      // Iterate through orders array in each document
      for (var order in orders) {
        if (order['isLoad'] == false) {
          // Check if 'isLoad' is false
          filteredOrders.add(order);
        }
      }
    }

    // Fetch data from 'Shop' collection
    QuerySnapshot shopQuerySnapshot =
        await FirebaseFirestore.instance.collection('Shop').get();

    // Iterate through documents in 'Shop' collection
    for (var doc in shopQuerySnapshot.docs) {
      List<dynamic> orders = doc['orders'];
      // Iterate through orders array in each document
      for (var order in orders) {
        if (order['isLoad'] == false) {
          // Check if 'isLoad' is false
          filteredOrders.add(order);
        }
      }
    }

    return filteredOrders;
  }

  Future<void> updateOrderIsLoad(
      String orderId, sellTo, sellPrice, int total) async {
    // Fetch data from 'Mill' collection
    QuerySnapshot millQuerySnapshot =
        await FirebaseFirestore.instance.collection('Mill').get();

    // Iterate through documents in 'Mill' collection
    for (var doc in millQuerySnapshot.docs) {
      List<dynamic> orders = doc['orders'];
      // Iterate through orders array in each document
      for (var order in orders) {
        if (order['orderID'] == orderId) {
          // Check if 'orderID' matches
          await FirebaseFirestore.instance
              .collection('Mill')
              .doc(doc.id)
              .update({
            'orders': FieldValue.arrayRemove([order]), // Remove the order
          });
          await FirebaseFirestore.instance
              .collection('Mill')
              .doc(doc.id)
              .update({
            'totalTons': FieldValue.increment(-total),
            'orders': FieldValue.arrayUnion([
              {
                ...order,
                'isLoad': true,
                'sellTo': sellTo,
                'sellPrice': sellPrice,
                'brokerHaveTons': '0',
              } // Add the updated order with 'isLoad' set to true
            ]),
          });
        }
      }
    }

    // Fetch data from 'Shop' collection
    QuerySnapshot shopQuerySnapshot =
        await FirebaseFirestore.instance.collection('Shop').get();

    // Iterate through documents in 'Shop' collection
    for (var doc in shopQuerySnapshot.docs) {
      List<dynamic> orders = doc['orders'];
      // Iterate through orders array in each document
      for (var order in orders) {
        if (order['orderID'] == orderId) {
          // Check if 'orderID' matches
          await FirebaseFirestore.instance
              .collection('Shop')
              .doc(doc.id)
              .update({
            'orders': FieldValue.arrayRemove([order]), // Remove the order
          });
          await FirebaseFirestore.instance
              .collection('Shop')
              .doc(doc.id)
              .update({
            'totalTons': FieldValue.increment(-total),
            'orders': FieldValue.arrayUnion([
              {
                ...order,
                'isLoad': true,
                'sellTo': sellTo,
                'sellPrice': sellPrice,
                'brokerHaveTons': '0',
              } // Add the updated order with 'isLoad' set to true
            ]),
          });
        }
      }
    }
  }

  Future<void> justDelete(String orderId, int total) async {
    // Fetch data from 'Mill' collection
    QuerySnapshot millQuerySnapshot =
        await FirebaseFirestore.instance.collection('Mill').get();

    // Iterate through documents in 'Mill' collection
    for (var doc in millQuerySnapshot.docs) {
      List<dynamic> orders = doc['orders'];
      // Iterate through orders array in each document
      for (var order in orders) {
        if (order['orderID'] == orderId) {
          // Check if 'orderID' matches
          await FirebaseFirestore.instance
              .collection('Mill')
              .doc(doc.id)
              .update({
            'orders': FieldValue.arrayRemove([order]), // Remove the order
          });
          await FirebaseFirestore.instance
              .collection('Mill')
              .doc(doc.id)
              .update({
            'totalTons': FieldValue.increment(-total),
          });
        }
      }
    }

    // Fetch data from 'Shop' collection
    QuerySnapshot shopQuerySnapshot =
        await FirebaseFirestore.instance.collection('Shop').get();

    // Iterate through documents in 'Shop' collection
    for (var doc in shopQuerySnapshot.docs) {
      List<dynamic> orders = doc['orders'];
      // Iterate through orders array in each document
      for (var order in orders) {
        if (order['orderID'] == orderId) {
          // Check if 'orderID' matches
          await FirebaseFirestore.instance
              .collection('Shop')
              .doc(doc.id)
              .update({
            'orders': FieldValue.arrayRemove([order]), // Remove the order
          });

          await FirebaseFirestore.instance
              .collection('Shop')
              .doc(doc.id)
              .update({
            'totalTons': FieldValue.increment(-total),
          });
        }
      }
    }
  }

  Future<void> getData() async {
    await fetchDataFromFirestore();
    await fetchOrdersFromFirestore();
    await fetchDataFromFirestoreBroker();
    return await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = [
      LiquidPullToRefresh(onRefresh: getData, child: homeScreen()),
      LiquidPullToRefresh(onRefresh: getData, child: LedgerScreen()),
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () async {
            // _onAlertButtonsPressed(context);
            MyAppComponents.goToPage(
                context: context,
                navigateTo: Upload(
                  title: 'Purchasing',
                  gridData: await fetchDataFromFirestore(),
                ));
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          )),
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_tree_outlined),
            label: 'Ledger',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget homeScreen() {
    return SafeArea(
      child: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Mill').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              // List<dynamic> allOrders = [];
              // for (var doc in snapshot.data!.docs) {
              //   List<dynamic> orders = doc['orders'];
              //   // int totalTons = doc['totalTons'];
              //   // totalOrders += totalTons;
              //   allOrders.addAll(orders);
              // }
              // allOrders.sort((a, b) {
              //   final dateTimeA = DateTime.parse(a['dateTime']);
              //   final dateTimeB = DateTime.parse(b['dateTime']);
              //   return dateTimeB.compareTo(dateTimeA);
              // });

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset('assets/shopcard.jpeg'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Text(
                              totalOrders.toString(),
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 50,
                                  fontWeight: FontWeight.w900),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 5),
                              child: Text(
                                'Tons Mills',
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                        Row(
                          children: [
                            Text(
                              totalOrdersShop.toString(),
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 50,
                                  fontWeight: FontWeight.w900),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 5),
                              child: Text(
                                'Tons Shop',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    gridData.isEmpty
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                    gridData.isEmpty
                        ? Container()
                        : const Text(
                            '-- Available Tons --',
                            style: TextStyle(fontSize: 20),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: GridView.count(
                        crossAxisCount: 5,
                        shrinkWrap: true,
                        crossAxisSpacing: 10,
                        physics: NeverScrollableScrollPhysics(),
                        children: gridData.map((data) {
                          return Visibility(
                            visible: data['totalTons'] > 0,
                            child: Text(
                              '${data['millType']}\n${data['totalTons']}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    gridDataBroker.isEmpty
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                    gridDataBroker.isEmpty
                        ? Container()
                        : const Text(
                            '-- Broker\'s --',
                            style: TextStyle(fontSize: 20),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: GridView.count(
                        crossAxisCount: 5,
                        shrinkWrap: true,
                        crossAxisSpacing: 10,
                        physics: NeverScrollableScrollPhysics(),
                        children: gridDataBroker.map((data) {
                          return Visibility(
                            visible: data['totalTons'] > 0,
                            child: Text(
                              '${data['brokerName']}\n${data['totalTons']}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    filteredOrders.isEmpty
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                    filteredOrders.isEmpty
                        ? Container()
                        : const Text(
                            '-- Pending Ton\'s --',
                            style: TextStyle(fontSize: 20),
                          ),
                    ListView.builder(
                      itemCount: filteredOrders.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        Map<String, dynamic> order = filteredOrders[index];
                        return InkWell(
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Want to delete this order ?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('No')),
                                    TextButton(
                                        onPressed: () {
                                          int currentTons =
                                              int.parse(order['tons']);
                                          justDelete(
                                                  order['orderID'], currentTons)
                                              .whenComplete(
                                                  () => Navigator.pop(context));
                                        },
                                        child: Text('Yes'))
                                  ],
                                );
                              },
                            );
                          },
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                TextEditingController customerName =
                                    TextEditingController();
                                TextEditingController tonPrice =
                                    TextEditingController();
                                String newDealerName = '';
                                String duePrice = '';

                                return AlertDialog(
                                  title: Text(
                                      'Loading ${order['brokerName']} to ?'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: customerName,
                                        decoration: InputDecoration(
                                            labelText: 'Customer Name'),
                                        onChanged: (value) {
                                          newDealerName = value;
                                        },
                                      ),
                                      TextField(
                                        controller: tonPrice,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]')),
                                        ],
                                        decoration: InputDecoration(
                                            labelText: 'Due Price'),
                                        onChanged: (value) {
                                          duePrice = value;
                                        },
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        // Close the dialog
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        if (customerName.text.isNotEmpty &&
                                            tonPrice.text.isNotEmpty) {
                                          int currentTons =
                                              int.parse(order['tons']);

                                          updateOrderIsLoad(
                                                  order['orderID'],
                                                  customerName.text,
                                                  tonPrice.text,
                                                  currentTons)
                                              .whenComplete(
                                                  () => Navigator.pop(context));
                                        } else {
                                          CustomSnackBar(
                                              context,
                                              Text(
                                                  'Please Put the Name and Price...'));
                                        }
                                      },
                                      child: Text('Load'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 40,
                                  child: Text(MyAppComponents.getFormattedDate(
                                      order['dateTime'])),
                                ),
                                SizedBox(
                                    width: 120,
                                    child: Text(order['brokerName'])),
                                SizedBox(
                                    width: 60, child: Text(order['millType'])),
                                SizedBox(
                                    width: 60,
                                    child: Text(
                                        '${order['brokerHaveTons']} Tons')),
                                SizedBox(
                                  width: 20,
                                  child: Icon(
                                    Icons.fire_truck_rounded,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
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
