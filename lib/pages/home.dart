// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_crud_basic/Helper/Dialog/confirm.dart';
import 'package:flutter_crud_basic/pages/adddata.dart';
import 'package:flutter_crud_basic/pages/detail.dart';
import 'package:flutter_crud_basic/pages/editdata.dart';
import 'package:flutter_crud_basic/services/item.dart';
//import 'package:crud_mysql/detail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Store"),
          leading: const Icon(Icons.list),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const AddData()))),
        body: FutureBuilder<List<dynamic>>(
            future: ItemServices.getData(context),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return const Center(child: Text("An error occurred!"));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ItemList(list: snapshot.data!);
              } else {
                return const Center(child: Text("No data found!"));
              }
              // return ItemList(
              //     list: snapshot.data ??
              //         [
              //           {
              //             "item_id": "1",
              //             "item_code": "001",
              //             "itemName": "Item 1",
              //             "stock": "10",
              //             "price": "10000"
              //           },
              //           {
              //             "item_id": "2",
              //             "item_code": "002",
              //             "itemName": "Item 2",
              //             "stock": "20",
              //             "price": "20000"
              //           }
              //         ]);
            }));
  }
}

class ItemList extends StatelessWidget {
  final List list;
  const ItemList({super.key, required this.list});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, i) {
          return Container(
            padding: const EdgeInsets.all(5.0),
            child: Card(
                child: ListTile(
              title: Text(list[i]['itemName']),
              leading: const Icon(Icons.widgets),
              subtitle: Text("Stock: ${list[i]['stock']}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40.0,
                    decoration: const BoxDecoration(
                        // borderRadius: BorderRadius.circular(5.0),
                        shape: BoxShape.circle,
                        color: Colors.orangeAccent),
                    child: IconButton(
                      icon: const Icon(Icons.edit,
                          color: Colors.white, size: 20.0),
                      // padding: const EdgeInsets.all(0.0), // Mengatur padding
                      // constraints: BoxConstraints(), // Hapus batasan default
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => EditData(
                                  list: list,
                                  index: i,
                                )));
                      },
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Container(
                    width: 40.0,
                    decoration: const BoxDecoration(
                        // borderRadius: BorderRadius.circular(5.0),
                        shape: BoxShape.circle,
                        color: Colors.orangeAccent),
                    child: IconButton(
                      icon: const Icon(Icons.delete,
                          color: Colors.white, size: 20.0),
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      // padding: const EdgeInsets.all(0.0), // Mengatur padding
                      // constraints: BoxConstraints(), // Hapus batasan default
                      onPressed: () {
                        ConfirmHelper.confirmDelete(context,
                            callback: () =>
                                ItemServices.deleteData(context, list[i]['id']));
                      },
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Detail(
                          id: list[i]['id'].toString(),
                        )));
              },
            )),
          );
        });
  }
}



/*
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List> getData() async {
    final response = await http.get("http://10.0.2.2/my_store/getdata.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("My Store")),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => AddData())),
        ),
        body: FutureBuilder<List>(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? ItemList(list: snapshot.data)
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            }));
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
            padding: EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    Detail(list: list, index: i),
              )),
              child: Card(
                  child: ListTile(
                title: Text(list[i]['itemName']),
                leading: Icon(Icons.widgets),
                subtitle: Text("Stock: ${list[i]['stock']}"),
              )),
            ));
      },
    );
  }
}
*/
