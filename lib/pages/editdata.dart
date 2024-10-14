// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_crud_basic/services/item.dart';

class EditData extends StatefulWidget {
  final int index;
  final List list;

  const EditData({super.key, required this.index, required this.list});
  @override
  // ignore: library_private_types_in_public_api
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  late TextEditingController controllerCode;
  late TextEditingController controllerName;
  late TextEditingController controllerPrice;
  late TextEditingController controllerStock;

  @override
  void initState() {
    controllerCode =
        TextEditingController(text: widget.list[widget.index]['itemCode']);
    controllerName =
        TextEditingController(text: widget.list[widget.index]['itemName']);
    controllerPrice = TextEditingController(
        text: widget.list[widget.index]['price'].toString());
    controllerStock = TextEditingController(
        text: widget.list[widget.index]['stock'].toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("EDIT DATA")),
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
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter
                        .digitsOnly, // Membatasi input hanya angka
                  ],
                  decoration: const InputDecoration(
                      hintText: "Price", labelText: "Price")),
              TextField(
                  controller: controllerStock,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter
                        .digitsOnly, // Membatasi input hanya angka
                  ],
                  decoration: const InputDecoration(
                      hintText: "Stock", labelText: "Stock")),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .orangeAccent, // Mengganti 'color' menjadi 'backgroundColor'
                ),
                onPressed: () {
                  ItemServices.editData(
                      context,
                      controllerCode.text,
                      controllerName.text,
                      controllerPrice.text,
                      controllerStock.text,
                      widget.list[widget.index]['id']);
                },
                child: const Text(
                  "EDIT DATA",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
