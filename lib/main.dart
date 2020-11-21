import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(new MaterialApp(
    title: "Print Zone",
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<List> getData() async {
    final response = await http.get("http://lensalgorithm.com/pz/getdata.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PrintzONE Admin"),
      ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  get i => i;

  void deleteData() {
    var url = "http://lensalgorithm.com/pz/deleteData.php";
    http.post(url, body: {'id': list[i]['id']});
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: EdgeInsets.all(10.0),
          child: Card(
            child: new ListTile(
              title: new Text('Nomor Antrean Cetak : ' + list[i]['id']),
              trailing: InkWell(
                onTap: () {
                  deleteData();
                },
                child: Container(
                  child: new Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
