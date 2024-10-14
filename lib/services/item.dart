// lib/data_helper.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_crud_basic/Helper/Dialog/alert.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_crud_basic/pages/home.dart';

// const url = "http://192.168.0.103/items/";
const url = "http://192.168.1.8/items/";

class ItemServices {
  static Future<List<dynamic>> getData(context) async {
    return await http.get(Uri.parse(url)).then((response) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == 200) {
        return responseData['data'];
      } else {
        AlertHelper.alertError(context, message: responseData['message']);
        return List.empty();
      }
    }).catchError((e) {
      AlertHelper.alertError(context, message: e.toString());
      return List.empty();
    });
  }

  static Future<Map<String, dynamic>> fetchDataById(context, id) async {
    return await http.get(Uri.parse(url + id)).then((response) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == 200) {
        return responseData['data'];
      } else {
        AlertHelper.alertError(context, message: responseData['message']);
        return;
      }
    }).catchError((e) {
      AlertHelper.alertError(context, message: e.toString());
      return;
    });
  }

  static void addData(context, code, name, price, stock) {
    final body = jsonEncode(
        {"itemCode": code, "itemName": name, "price": price, "stock": stock});

    http.post(Uri.parse(url),
        body: body,
        headers: {'Content-Type': 'application/json'}).then((response) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == 201) {
        AlertHelper.alertSuccess(context, message: responseData['message'])
            .then((_) => {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const Home(),
                  ))
                });
      } else {
        AlertHelper.alertError(context, message: responseData['message']);
      }
    }).catchError((e) {
      AlertHelper.alertError(context, message: e.toString());
    });
    //bagian then response untuk melihat error, jika tidak ada error bisa dihapus
  }

  static void editData(context, code, name, price, stock, id) {
    final body = jsonEncode(
        {"itemCode": code, "itemName": name, "price": price, "stock": stock});
    http.put(Uri.parse(url + id),
        body: body,
        headers: {'Content-Type': 'application/json'}).then((response) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == 200) {
        AlertHelper.alertSuccess(context, message: responseData['message'])
            .then((_) => {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const Home(),
                  ))
                });
      } else {
        AlertHelper.alertError(context, message: responseData['message']);
      }
    }).catchError((e) {
      AlertHelper.alertError(context, message: e.toString());
    });
  }

  static void deleteData(BuildContext context, String id) {
    http.delete(Uri.parse(url + id)).then((response) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == 200) {
        AlertHelper.alertSuccess(context, message: responseData['message'])
            .then((_) => {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const Home(),
                  ))
                });
      } else {
        AlertHelper.alertError(context, message: responseData['message']);
      }
    }).catchError((e) {
      AlertHelper.alertError(context, message: e.toString());
    });
  }

  // static Future alertMessageTime(BuildContext context, String message,
  //     {String title = "Error", Color colorButton = Colors.red}) {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         Future.delayed(const Duration(seconds: 5), () {
  //           Navigator.of(context).pop(); // Menutup dialog
  //         });

  //         return AlertDialog(
  //           // title: Text(""),
  //           content: Text(message, style: const TextStyle(fontSize: 16.0)),
  //           actions: <Widget>[
  //             ElevatedButton(
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: colorButton,
  //               ),
  //               onPressed: () => Navigator.pop(context),
  //               child: const Text("OK", style: TextStyle(color: Colors.white)),
  //             ),
  //           ],
  //         );
  //       });
  // }

  // static void confirm(BuildContext context, String id, String itemName) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       content: Container(
  //         padding: const EdgeInsets.only(top: 12.0),
  //         child: Text(
  //           "Are you sure want to delete '$itemName'?",
  //           style: const TextStyle(fontSize: 16.0),
  //         ),
  //       ),
  //       actions: <Widget>[
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: <Widget>[
  //             ElevatedButton(
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: Colors.red,
  //               ),
  //               onPressed: () {
  //                 deleteData(context, id);
  //               },
  //               child: const Text("OK DELETE!",
  //                   style: TextStyle(color: Colors.white)),
  //             ),
  //             ElevatedButton(
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: Colors.grey,
  //               ),
  //               onPressed: () => Navigator.pop(context),
  //               child:
  //                   const Text("CANCEL", style: TextStyle(color: Colors.white)),
  //             ),
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }
}
