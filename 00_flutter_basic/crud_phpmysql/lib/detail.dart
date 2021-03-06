import 'package:flutter/material.dart';
import 'editData.dart';
import 'package:http/http.dart' as http;

import 'home.dart';


class Detail extends StatefulWidget {

  final List list;
  final int index;
  Detail({this.index, this.list});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  void deleteData(){
    var url = "http://192.168.1.146/xdev/xlearn/flutter_mystore/deleteData.php";
    http.post(url,body:{
      "id" : widget.list[widget.index]['id']
    });
  }

  void confirm(){
    AlertDialog alertDialog = new AlertDialog(
      content: Text("Are you sure want to delete '${widget.list[widget.index]['item_name']}' ?"),
      actions: <Widget>[
        new RaisedButton(
          child: Text("Oke! Delete",style: TextStyle(color: Colors.white),),
          color: Colors.blue,
          onPressed: () {
            deleteData();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => new Home(),
              )
            );
          },
        ),
        new RaisedButton(
          child: Text("Cancel",style: TextStyle(color: Colors.white),),
          color: Colors.red,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(context: context,child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("${widget.list[widget.index]['item_name']}"),
      ),
      
      body: new Container(
        height: 250.0,
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Padding(padding: const EdgeInsets.only(top: 30.0),),
                new Text(widget.list[widget.index]['item_name'], style: new TextStyle(fontSize: 20.0),),
                new Text("Kode : ${widget.list[widget.index]['item_code']}", style: new TextStyle(fontSize: 18.0),),
                new Text("Harga : ${widget.list[widget.index]['price']}", style: new TextStyle(fontSize: 18.0),),
                new Text("Stok : ${widget.list[widget.index]['stock']}", style: new TextStyle(fontSize: 18.0),),
                new Padding(padding: const EdgeInsets.only(top: 30.0),),

                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new RaisedButton(
                      child: new Text("Edit"),
                      color: Colors.green,
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) => EditData(list: widget.list, index: widget.index,))
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(10.0),),
                    new RaisedButton(
                      child: new Text("Delete"),
                      color: Colors.red,
                      onPressed: () => confirm(),
                    ),
                  ],
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}