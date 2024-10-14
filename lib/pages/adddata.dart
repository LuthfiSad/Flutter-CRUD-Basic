// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_crud_basic/services/item.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController controllerCode = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerStock = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("ADD DATA")),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: ListView(children: <Widget>[
            Column(
              children: <Widget>[
                TextField(
                    controller: controllerCode,
                    decoration: const InputDecoration(
                        hintText: "Item Code", labelText: "Item Code")),
                TextField(
                    controller: controllerName,
                    decoration: const InputDecoration(
                        hintText: "Item Name", labelText: "Item Name")),
                TextField(
                  controller: controllerPrice,
                  keyboardType:
                      TextInputType.number, // Menampilkan keyboard angka
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter
                        .digitsOnly, // Membatasi input hanya angka
                  ],
                  decoration: const InputDecoration(
                    hintText: "Price",
                    labelText: "Price",
                  ),
                ),
                TextField(
                  controller: controllerStock,
                  keyboardType:
                      TextInputType.number, // Menampilkan keyboard angka
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter
                        .digitsOnly, // Membatasi input hanya angka
                  ],
                  decoration: const InputDecoration(
                    hintText: "Stock",
                    labelText: "Stock",
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    ItemServices.addData(
                        context,
                        controllerCode.text,
                        controllerName.text,
                        controllerPrice.text,
                        controllerStock.text); //untuk kembali ke halaman awal setelah data ditambahkan
                  },
                  child: const Text("ADD DATA",
                      style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ]),
        ));
  }
}
