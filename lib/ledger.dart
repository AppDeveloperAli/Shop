import 'package:baboo_and_co/Components/designs.dart';
import 'package:baboo_and_co/Components/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LedgerScreen extends StatefulWidget {
  const LedgerScreen({Key? key}) : super(key: key);

  @override
  State<LedgerScreen> createState() => _LedgerScreenState();
}

class _LedgerScreenState extends State<LedgerScreen> {
  List<dynamic> allOrders = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      List<dynamic> orders = await fetchOrdersFromFirestore();
      setState(() {
        allOrders = orders;
        isLoading = false;
      });
    } catch (e) {
      // Handle error
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<List<dynamic>> fetchOrdersFromFirestore() async {
    List<dynamic> allOrders = [];

    QuerySnapshot collection1QuerySnapshot =
        await FirebaseFirestore.instance.collection('Mill').get();

    for (var doc1 in collection1QuerySnapshot.docs) {
      List<dynamic> orders = doc1['orders'];
      allOrders.addAll(orders);
    }

    QuerySnapshot collection2QuerySnapshot =
        await FirebaseFirestore.instance.collection('Shop').get();

    for (var doc2 in collection2QuerySnapshot.docs) {
      List<dynamic> orders = doc2['orders'];
      allOrders.addAll(orders);
    }

    return allOrders;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Daily Rollout',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListView.builder(
                      itemCount: allOrders.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> order = allOrders[index];
                        return MyAppDesigns.ledgerTitle(
                            MyAppComponents.getFormattedDate(order['dateTime']),
                            order['isLoad']
                                ? order['sellTo']
                                : order['brokerName'],
                            order['millType'],
                            order['tons'],
                            order['isLoad']
                                ? order['sellPrice']
                                : order['due_price'],
                            order['isLoad'],
                            context);
                        // return ListTile(
                        //   title: Text(order['brokerName']),
                        //   subtitle:
                        //       Text('Broker Tons: ${order['brokerHaveTons']}'),
                        //   // Add more widgets to display additional order information as needed
                        // );
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
