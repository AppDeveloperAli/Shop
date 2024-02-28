// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:baboo_and_co/Components/designs.dart';
import 'package:baboo_and_co/Widgets/snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatefulWidget {
  final List<dynamic>? data;
  final String title;
  final bool isShop, isCustomer;

  DetailsScreen({
    Key? key,
    required this.title,
    required this.isShop,
    required this.isCustomer,
    required this.data,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String getFormattedDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDateTime = DateFormat('dd-MM').format(dateTime);
    return formattedDateTime;
  }

  List<dynamic> filterOrdersByDealerName(
      List<dynamic> allOrders, String dealerName) {
    return allOrders
        .where((order) => order['dealer_name'] == dealerName)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> allOrdersShop = [];
    if (widget.data != null && widget.data!.isNotEmpty) {
      for (var doc in widget.data!) {
        if (doc['orders'] != null) {
          List<dynamic> orders = doc['orders'];
          allOrdersShop.addAll(orders);
        }
      }
      allOrdersShop.sort((a, b) {
        final dateTimeA = DateTime.parse(a['dateTime']);
        final dateTimeB = DateTime.parse(b['dateTime']);
        return dateTimeB.compareTo(dateTimeA);
      });
    }

    List<dynamic> filteredOrders =
        filterOrdersByDealerName(widget.data!, widget.title);

    // Get unique millType values
    Set<String> uniqueMillTypes =
        Set.from(filteredOrders.map((order) => order['millType']));

    void updateOrderInFirebase(
        String orderId,
        String millType,
        String collection,
        String newDealerName,
        String newTons,
        String duePrice) {
      FirebaseFirestore.instance
          .collection(collection)
          .where('millType', isEqualTo: millType)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          // Get the array field (assuming it's named 'orders')
          List<dynamic> orders = doc['orders'];

          // Find the order with the matching order ID
          int index = orders.indexWhere((order) => order['orderID'] == orderId);

          if (index != -1) {
            // Update the specific fields within the order
            orders[index]['dealer_name'] = newDealerName;
            orders[index]['tons'] = newTons;
            orders[index]['due_price'] = duePrice;

            // Update the document in Firestore
            FirebaseFirestore.instance
                .collection(collection)
                .doc(doc.id)
                .update({'orders': orders}).then((value) {
              CustomSnackBar(context, Text('Order updated successfully'));
            }).catchError((error) {
              CustomSnackBar(context, Text('Failed to update order: $error'));
            });
          }
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.black,
                ),
                MyAppDesigns.detailsTitle(widget.isShop),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.black,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredOrders.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onLongPress: () {
                        // Show a dialog with text fields for user input
                        showDialog(
                          context: context,
                          builder: (context) {
                            String newDealerName = '';
                            String newTons = '';
                            String duePrice = '';

                            return AlertDialog(
                              title: Text('Edit Order'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    decoration: InputDecoration(
                                        labelText: 'New Dealer Name'),
                                    onChanged: (value) {
                                      newDealerName = value;
                                    },
                                  ),
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    decoration:
                                        InputDecoration(labelText: 'New Tons'),
                                    onChanged: (value) {
                                      newTons = value;
                                    },
                                  ),
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    decoration: InputDecoration(
                                        labelText: 'New Due Price'),
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
                                    if (newDealerName.isNotEmpty &&
                                        newTons.isNotEmpty &&
                                        duePrice.isNotEmpty) {
                                      updateOrderInFirebase(
                                        filteredOrders[index]['orderID'],
                                        filteredOrders[index]['millType'],
                                        widget.isShop ? 'Shop' : 'Mill',
                                        newDealerName,
                                        newTons,
                                        duePrice, // Convert to int if necessary
                                      );
                                      // Close the dialog
                                      Navigator.of(context).pop();
                                    } else {
                                      CustomSnackBar(
                                          context,
                                          Text(
                                              'Please fill all required fields.'));
                                    }
                                  },
                                  child: Text('Save'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: MyAppDesigns.detailsOrder(
                        getFormattedDate(filteredOrders[index]['dateTime']),
                        filteredOrders[index]['dealer_name'],
                        filteredOrders[index]['tons'],
                        filteredOrders[index]['due_price'],
                        filteredOrders[index]['millType'],
                        filteredOrders[index]['orderType'] == 'Purchasing'
                            ? false
                            : true,
                      ),
                    );
                  },
                ),
                for (var millType in uniqueMillTypes)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          '-- $millType --',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      MyAppDesigns.detailsTitle(widget.isShop),
                      Divider(
                        height: 0,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: filteredOrders.length,
                        itemBuilder: (context, index) {
                          if (filteredOrders[index]['millType'] == millType) {
                            return MyAppDesigns.detailsOrder(
                              getFormattedDate(
                                  filteredOrders[index]['dateTime']),
                              filteredOrders[index]['dealer_name'],
                              filteredOrders[index]['tons'],
                              filteredOrders[index]['due_price'],
                              filteredOrders[index]['millType'],
                              filteredOrders[index]['orderType'] == 'Purchasing'
                                  ? false
                                  : true,
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
