// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:baboo_and_co/purchase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text('You want to ?'),
                    // content: Text('Do you really want to delete?'),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) => PurchaseScreen(
                                      title: 'Selling',
                                    )));
                          },
                          child: Text('Sell')),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);

                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => PurchaseScreen(
                                    title: 'Purchasing',
                                  )));
                        },
                        child: Text('Buy'),
                      )
                    ],
                  );
                });
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/shopcard.jpeg'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '37',
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
                      Row(
                        children: [
                          Text(
                            '24',
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
                      )
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              _tabSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget order(String dealer, bandhi, sakrand, khairpur, ranipur) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Column(
          children: [
            Divider(
              color: Colors.black12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    dealer,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                Text(':'),
                SizedBox(
                  width: 40,
                  child: Center(
                    child: Text(
                      bandhi,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Text(':'),
                SizedBox(
                  width: 40,
                  child: Center(
                    child: Text(
                      khairpur,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Text(':'),
                SizedBox(
                  width: 40,
                  child: Center(
                    child: Text(
                      ranipur,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Text(':'),
                SizedBox(
                  width: 40,
                  child: Center(
                    child: Text(
                      sakrand,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget total(String dealer, bandhi, sakrand, khairpur, ranipur) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    dealer,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                Text(
                  ':',
                  style: TextStyle(color: Colors.transparent),
                ),
                SizedBox(
                  width: 40,
                  child: Center(
                    child: Text(
                      bandhi,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                ),
                Text(':'),
                SizedBox(
                  width: 40,
                  child: Center(
                    child: Text(
                      khairpur,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                ),
                Text(':'),
                SizedBox(
                  width: 40,
                  child: Center(
                    child: Text(
                      ranipur,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                ),
                Text(':'),
                SizedBox(
                  width: 40,
                  child: Center(
                    child: Text(
                      sakrand,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget title() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              'Party Name',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.transparent),
            ),
          ),
          Text(
            ':',
            style: TextStyle(color: Colors.transparent),
          ),
          Text(
            'BNDHI',
            style: TextStyle(fontSize: 17, color: Colors.red),
          ),
          Text(':'),
          Text(
            'KHRPR',
            style: TextStyle(fontSize: 17, color: Colors.red),
          ),
          Text(':'),
          Text(
            'RNPR',
            style: TextStyle(fontSize: 17, color: Colors.red),
          ),
          Text(':'),
          Text(
            'SKRD',
            style: TextStyle(fontSize: 17, color: Colors.red),
          )
        ],
      ),
    );
  }

  Widget _tabSection(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TabBar(tabs: [
            Tab(text: "Shop"),
            Tab(text: "Mills"),
          ]),
          SizedBox(
            //Add this to give height
            height: MediaQuery.of(context).size.height,
            child: TabBarView(children: [
              shop(),
              mills(),
            ]),
          ),
        ],
      ),
    );
  }

  Widget shop() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          title(),
          order('Dyal Das Munshi', '12', '43', '21', '32'),
          order('Yameen Malik', '12', '43', '21', '42'),
          order('Muhammad Yaar', '12', '43', '21', '13'),
          order('Tufail Brothers', '12', '43', '21', '42'),
          order('Hashim Goods', '12', '43', '21', '12'),
          order('Sabtan Kamboh', '12', '43', '21', '56'),
          order('Adnan Malik', '12', '43', '21', '95'),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Divider(
              color: Colors.black,
            ),
          ),
          total('Total', '321', '467', '321', '234')
        ],
      ),
    );
  }

  Widget mills() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          title(),
          order('Dyal Das Munshi', '12', '43', '21', '32'),
          order('Yameen Malik', '12', '43', '21', '42'),
          order('Muhammad Yaar', '12', '43', '21', '13'),
          order('Tufail Brothers', '12', '43', '21', '42'),
          order('Hashim Goods', '12', '43', '21', '12'),
          order('Sabtan Kamboh', '12', '43', '21', '56'),
          order('Adnan Malik', '12', '43', '21', '95'),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Divider(
              color: Colors.black,
            ),
          ),
          total('Total', '321', '467', '321', '123')
        ],
      ),
    );
  }
}
