import 'package:baboo_and_co/Widgets/snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class MyAppComponents {
  static goToPage({required BuildContext context, required Widget navigateTo}) {
    return Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => navigateTo,
      ),
    );
  }

  static getCurrentTimeFormatted() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String formattedTime = formatter.format(now);
    return formattedTime;
  }

  static generateUniqueId() {
    var uuid = const Uuid();
    String id = uuid.v4();
    return id;
  }

  static buyItem(
      BuildContext context,
      String collectionName,
      millName,
      title,
      TextEditingController tonsController,
      customerController,
      duePriceController) {
    int tonsToAdd = int.parse(tonsController.text);
    int tonsToSubtract = -tonsToAdd;

    FirebaseFirestore.instance
        .collection(collectionName)
        .doc(millName)
        .get()
        .then((DocumentSnapshot docSnapshot) {
      if (docSnapshot.exists) {
        // Document exists, update it
        docSnapshot.reference.update({
          'totalTons': FieldValue.increment(tonsToAdd),
          'millType': millName,
          'orders': FieldValue.arrayUnion([
            {
              'dealer_name': customerController.text,
              'tons': tonsController.text,
              'due_price': duePriceController.text,
              'millType': millName,
              'orderType': title,
              'dateTime': getCurrentTimeFormatted(),
              'orderID': generateUniqueId(),
            }
          ]),
        }).then((value) {
          CustomSnackBar(context, const Text('Order updated successfully!'));
          Navigator.pop(context);
        }).catchError((error) {
          CustomSnackBar(context, Text('Failed to update document: $error'));
        });
      } else {
        // Document doesn't exist, create it
        FirebaseFirestore.instance
            .collection(collectionName)
            .doc(millName)
            .set({
          'totalTons': tonsToAdd,
          'millType': millName,
          'orders': [
            {
              'dealer_name': customerController.text,
              'tons': tonsController.text,
              'due_price': duePriceController.text,
              'millType': millName,
              'orderType': title,
              'dateTime': getCurrentTimeFormatted(),
              'orderID': generateUniqueId(),
            }
          ],
        }).then((value) {
          CustomSnackBar(context, const Text('Order created successfully!'));
          Navigator.pop(context);
        }).catchError((error) {
          CustomSnackBar(context, Text('Failed to create document: $error'));
        });
      }
    }).catchError((error) {
      CustomSnackBar(context, Text('Failed to get document: $error'));
    });
  }

  static sellItem(
      BuildContext context,
      String collectionName,
      millName,
      title,
      TextEditingController tonsController,
      customerController,
      duePriceController) {
    int tonsToAdd = int.parse(tonsController.text);
    int tonsToSubtract = -tonsToAdd;

    FirebaseFirestore.instance
        .collection(collectionName)
        .doc(millName)
        .get()
        .then((DocumentSnapshot docSnapshot) {
      if (docSnapshot.exists) {
        int currentValue =
            (docSnapshot.data() as Map<String, dynamic>)['totalTons'];
        int tonsToAdd = int.parse(tonsController.text);

        if (currentValue >= tonsToAdd) {
          // Proceed with decrementing the value and updating the document
          int tonsToSubtract = -tonsToAdd;

          docSnapshot.reference.update({
            'totalTons': FieldValue.increment(tonsToSubtract),
            'millType': millName,
            'orders': FieldValue.arrayUnion([
              {
                'dealer_name': customerController.text,
                'tons': tonsController.text,
                'due_price': duePriceController.text,
                'millType': millName,
                'orderType': title,
                'dateTime': getCurrentTimeFormatted(),
                'orderID': generateUniqueId(),
              }
            ]),
          }).then((value) {
            CustomSnackBar(context, const Text('Order updated successfully!'));
            Navigator.pop(context);
          }).catchError((error) {
            CustomSnackBar(context, Text('Failed to update document: $error'));
          });
        } else {
          // Display error message if the current value is less than what the user wants to subtract
          CustomSnackBar(
              context,
              const Text(
                  'You don\'t have enough tons in the selected warehouse.'));
        }
      } else {
        // Document doesn't exist, handle accordingly
        CustomSnackBar(
            context,
            const Text(
                'You didn\'t have enough tons in the selected warehouse.'));
      }
    }).catchError((error) {
      CustomSnackBar(context, Text('Failed to get document: $error'));
    }).catchError((error) {
      CustomSnackBar(context, Text('Failed to get document: $error'));
    });
  }
}
