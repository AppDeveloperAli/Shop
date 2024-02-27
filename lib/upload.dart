import 'package:baboo_and_co/Components/functions.dart';
import 'package:baboo_and_co/Widgets/TextField.dart';
import 'package:baboo_and_co/Widgets/snackBar.dart';
import 'package:flutter/material.dart';

class Upload extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> gridData;

  Upload({required this.title, required this.gridData});

  @override
  State<Upload> createState() => _PurchaseScreenState();
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

class _PurchaseScreenState extends State<Upload> {
  TextEditingController customerController = TextEditingController();
  TextEditingController tonsController = TextEditingController();
  TextEditingController duePriceController = TextEditingController();
  MillType? millType;
  Warehouse? shopType;
  bool isLoading = false;

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
                    GridView.count(
                      crossAxisCount: 5,
                      shrinkWrap: true,
                      crossAxisSpacing: 10,
                      children: widget.gridData.map((data) {
                        return Visibility(
                          visible: data['totalTons'] > 0,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${data['millType']}\n${data['totalTons']}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
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
                                allowOnlyNumericInput: true,
                              ),
                            ),
                          ),
                          Expanded(
                            child: MyTextInputText(
                              controller: duePriceController,
                              labelText: 'Due Price',
                              allowOnlyNumericInput: true,
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
            isLoading
                ? const CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              setState(() {
                                isLoading = true;
                              });
                              String millName =
                                  millType.toString().split('.').last;
                              String collectionName =
                                  shopType == Warehouse.Shop ? 'Shop' : 'Mill';
                              if (tonsController.text.isNotEmpty &&
                                  customerController.text.isNotEmpty &&
                                  duePriceController.text.isNotEmpty) {
                                if (widget.title == "Purchasing") {
                                  if (millType != null && shopType != null) {
                                    await MyAppComponents.buyItem(
                                        context,
                                        collectionName,
                                        millName,
                                        widget.title,
                                        tonsController,
                                        customerController,
                                        duePriceController);
                                  } else {
                                    CustomSnackBar(
                                        context,
                                        const Text(
                                            'You didn\'t select any Mill or Warehouse..'));
                                  }
                                } else if (widget.title == "Selling") {
                                  if (millType != null && shopType != null) {
                                    await MyAppComponents.sellItem(
                                        context,
                                        collectionName,
                                        millName,
                                        widget.title,
                                        tonsController,
                                        customerController,
                                        duePriceController);
                                  } else {
                                    CustomSnackBar(
                                        context,
                                        const Text(
                                            'You didn\'t select any Mill or Warehouse..'));
                                  }
                                }
                              } else {
                                CustomSnackBar(
                                    context,
                                    const Text(
                                        'Please Make sure you put all your informations.'));
                              }
                              setState(() {
                                isLoading = false;
                              });
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
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
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
