import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CrudPage extends StatefulWidget {
  CrudPage({Key key}) : super(key: key);

  @override
  _CrudPageState createState() => _CrudPageState();
}

class _CrudPageState extends State<CrudPage> {
  Map data;
  List<dynamic> doc;

  // Add
  addData() {
    Map<String, dynamic> data = {'name': 'Jahid hasan', 'Phone': '01962823007'};
    CollectionReference collectionReference =
        Firestore.instance.collection('info');
    collectionReference.add(data);
  }

  //Fetch

  fetchData() {
    CollectionReference collectionReference =
        Firestore.instance.collection('info');
    collectionReference.snapshots().listen((snapshot) {
      setState(() {
        data = snapshot.documents[0].data;
      });
    });
  }
  //Update

  updateDta() async {
    CollectionReference collectionReference =
        Firestore.instance.collection('info');
    QuerySnapshot querySnapshot = await collectionReference.getDocuments();
    querySnapshot.documents[0].reference.updateData({'name': 'Hasan,Md.Jahid'});
  }

  //Delete
  deleteData() async {
    CollectionReference collectionReference =
        Firestore.instance.collection('info');
    QuerySnapshot querySnapshot = await collectionReference.getDocuments();
    querySnapshot.documents[0].reference.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text(
          'CRUD Operation',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: FlatButton(
                    onPressed: () {
                      addData();
                    },
                    child: Text('Add Data'),
                    color: Colors.green,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: FlatButton(
                    onPressed: () {
                      fetchData();
                    },
                    child: Text('Fetch Data'),
                    color: Colors.yellow,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: FlatButton(
                    onPressed: () {
                      updateDta();
                    },
                    child: Text('Update Data'),
                    color: Colors.orange,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: FlatButton(
                    onPressed: () {
                      deleteData();
                    },
                    child: Text('Delete Data'),
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Text(
                  '$data',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
