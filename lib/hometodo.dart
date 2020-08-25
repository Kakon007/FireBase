import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeTodo extends StatefulWidget {
  HomeTodo({Key key}) : super(key: key);

  @override
  _HomeTodoState createState() => _HomeTodoState();
}

class _HomeTodoState extends State<HomeTodo> {
  var txtfield;
  var txtfieldadd;
  Firestore _firestore = Firestore();

  // void getMessage() async {
  //   final todos = await _firestore.collection('todo').getDocuments();
  //   for (var message in todos.documents) {
  //     print(message.data);
  //   }
  // }

  // void messageStream() async {
  //   await for (var snapshots in _firestore.collection('todo').snapshots()) {
  //     for (var snapshotss in snapshots.documents) {
  //       print(snapshotss.data);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('info').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final messages = snapshot.data.documents;
            List<Text> messageWidgets = [];
            for (var message in messages) {
              final messagetext = message.data['text'];
              final messagenumber = message.data['address'];

              final messagewidget = Text('$messagetext from $messagenumber');
              messageWidgets.add(messagewidget);
            }
            return Center(
              child: Column(
                children: messageWidgets,
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                'Todo List',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              content: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                        txtfield = value;
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    TextField(
                      onChanged: (value) {
                        txtfieldadd = value;
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                RaisedButton(
                  onPressed: () {
                    _firestore.collection('info').add({
                      'text': txtfield,
                      'address': txtfieldadd,
                    });
                    Navigator.of(context).pop();
                    //getMessage();
                    // messageStream();
                  },
                  child: Text('ADD'),
                  color: Colors.blue,
                )
              ],
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
