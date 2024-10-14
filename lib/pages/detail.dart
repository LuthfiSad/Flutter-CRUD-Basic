// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_crud_basic/Helper/Dialog/confirm.dart';
import 'package:flutter_crud_basic/pages/editdata.dart';
import 'package:flutter_crud_basic/services/item.dart';

class Detail extends StatefulWidget {
  final String id;
  const Detail({super.key, required this.id});
  // final List list;
  // final int index;
  // const Detail({super.key, required this.index, required this.list});
  @override
  // ignore: library_private_types_in_public_api
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Detail Data")),
        body: FutureBuilder<Map<String, dynamic>>(
            // future: fetchDataById(context, widget.list[widget.index]['id']),
            future: ItemServices.fetchDataById(context, widget.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Menampilkan loading saat data sedang di-fetch
                return const Center(
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: 0.5,
                        child: ModalBarrier(
                            dismissible: false, color: Colors.black),
                      ),
                      Center(child: CircularProgressIndicator())
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                // Menampilkan pesan error jika terjadi kesalahan
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Error occurred while fetching data!',
                        style: TextStyle(fontSize: 18.0, color: Colors.red),
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {}); // Refresh halaman
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                // Jika data kosong atau null
                return const Center(
                  child: Text(
                    'No data found',
                    style: TextStyle(fontSize: 18.0),
                  ),
                );
              } else {
                final item = snapshot.data!;
                return Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Card(
                        color: Colors.blue[50],
                        // child: Center(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Padding(
                                  padding: EdgeInsets.only(top: 30.0)),
                              Text("${item['itemName']}",
                                  style: const TextStyle(fontSize: 20.0)),
                              Text("Code  : ${item['itemCode']}",
                                  style: const TextStyle(fontSize: 18.0)),
                              Text("Price : ${item['price']}",
                                  style: const TextStyle(fontSize: 18.0)),
                              Text("Stok  : ${item['stock']}",
                                  style: const TextStyle(fontSize: 18.0)),
                              const Padding(
                                  padding: EdgeInsets.only(top: 10.0)),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 30.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors
                                              .orangeAccent, // Mengganti 'color' menjadi 'backgroundColor'
                                        ),
                                        onPressed: () =>
                                            Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                EditData(index: 0, list: [
                                              item
                                            ]), //penggunaan widget.list karena argumen list bukan berada pada class state
                                          ),
                                        ),
                                        child: const Text("EDIT",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 5.0, right: 5.0),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors
                                              .red, // Mengganti 'color' menjadi 'backgroundColor'
                                        ),
                                        onPressed: () =>
                                            ConfirmHelper.confirmDelete(context,
                                                callback: () =>
                                                    ItemServices.deleteData(
                                                        context, item['id'])),
                                        child: const Text("DELETE",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ]),
                              )
                            ])));
              }
            }));
  }
}
