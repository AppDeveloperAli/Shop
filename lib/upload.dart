// ignore_for_file: constant_identifier_names, use_build_context_synchronously

import 'package:baboo_and_co/Widgets/TextField.dart';
import 'package:baboo_and_co/Widgets/snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class PurchaseScreen extends StatefulWidget {
  String title;
  PurchaseScreen({super.key, required this.title});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

enum MillType {
  Sakrand,
  Bandhi,
  Khairpur,
  Ranipur,
  Alnoor,
  Ghotki,
  Deharki,
  Alliance,
  Kiran
}

enum Warehouse { Shop, Mill }

class _PurchaseScreenState extends State<PurchaseScreen> {
  TextEditingController customerController = TextEditingController();
  TextEditingController tonsController = TextEditingController();
  TextEditingController duePriceController = TextEditingController();
  MillType? millType;
  Warehouse? shopType;

  String getCurrentTimeFormatted() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String formattedTime = formatter.format(now);
    return formattedTime;
  }

  String generateUniqueId() {
    var uuid = const Uuid();
    String id = uuid.v4();
    return id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}...'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      '-- Available Tons --',
                      style: TextStyle(fontSize: 20),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Ranipur\n124',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Khairpur\n421',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Bandhi\n654',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Sakrand\n231',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Alnoor\n231',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Sakrand\n124',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Deharki\n421',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Ghotki\n654',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Alliance\n231',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Kiran\n231',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: MyTextInputText(
                        controller: customerController,
                        labelText: 'Dealer Name',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: MyTextInputText(
                                controller: tonsController,
                                labelText: 'Tons',
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                          Expanded(
                            child: MyTextInputText(
                              controller: duePriceController,
                              labelText: 'Due Price',
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        '-- Sugar Mills --',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(MillType.Bandhi.name),
                            value: MillType.Bandhi,
                            groupValue: millType,
                            onChanged: (value) {
                              setState(() {
                                millType = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(MillType.Khairpur.name),
                            value: MillType.Khairpur,
                            groupValue: millType,
                            onChanged: (value) {
                              setState(() {
                                millType = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(MillType.Ranipur.name),
                            value: MillType.Ranipur,
                            groupValue: millType,
                            onChanged: (value) {
                              setState(() {
                                millType = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(MillType.Deharki.name),
                            value: MillType.Deharki,
                            groupValue: millType,
                            onChanged: (value) {
                              setState(() {
                                millType = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(MillType.Ghotki.name),
                            value: MillType.Ghotki,
                            groupValue: millType,
                            onChanged: (value) {
                              setState(() {
                                millType = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(MillType.Alnoor.name),
                            value: MillType.Alnoor,
                            groupValue: millType,
                            onChanged: (value) {
                              setState(() {
                                millType = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(MillType.Alliance.name),
                            value: MillType.Alliance,
                            groupValue: millType,
                            onChanged: (value) {
                              setState(() {
                                millType = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(MillType.Kiran.name),
                            value: MillType.Kiran,
                            groupValue: millType,
                            onChanged: (value) {
                              setState(() {
                                millType = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(MillType.Sakrand.name),
                            value: MillType.Sakrand,
                            groupValue: millType,
                            onChanged: (value) {
                              setState(() {
                                millType = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        '-- Warehouse --',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(Warehouse.Shop.name),
                            value: Warehouse.Shop,
                            groupValue: shopType,
                            onChanged: (value) {
                              setState(() {
                                shopType = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(Warehouse.Mill.name),
                            value: Warehouse.Mill,
                            groupValue: shopType,
                            onChanged: (value) {
                              setState(() {
                                shopType = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        // placeOrder();

                        String millName = millType.toString().split('.').last;
                        String collectionName =
                            shopType == Warehouse.Shop ? 'Shop' : 'Mill';
                        if (tonsController.text.isNotEmpty &&
                            customerController.text.isNotEmpty &&
                            duePriceController.text.isNotEmpty) {
                          try {
                            await FirebaseFirestore.instance
                                .collection(collectionName)
                                .doc(millName)
                                .set({
                              'dealer_name': customerController.text,
                              'tons': tonsController.text,
                              'due_price': duePriceController.text,
                              'orderType': widget.title,
                              'dateTime': getCurrentTimeFormatted(),
                              'orderID': generateUniqueId()
                            });
                            CustomSnackBar(context,
                                const Text('Order placed successfully!'));
                          } catch (e) {
                            CustomSnackBar(
                                context, Text('Error placing order: $e'));
                          }
                        } else {
                          CustomSnackBar(
                              context,
                              const Text(
                                  'Please Make sure you put all your informations.'));
                        }
                      },
                      child: Card(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 5,
                        margin: const EdgeInsets.all(10),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              'Place an Order',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
