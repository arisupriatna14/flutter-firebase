import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDB extends StatefulWidget {
  FirestoreDB({Key key}) : super(key: key);

  _FirestoreDBState createState() => _FirestoreDBState();
}

class _FirestoreDBState extends State<FirestoreDB> {
  String id;
  final db = Firestore.instance;
  // String name, email;
  final _key = GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  send() async {
    DocumentReference ref = await db.collection('AEJ').add({
      "name": nameController.text,
      "email": emailController.text
    });
    print(ref.documentID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore'),
      ),
      body: Container(
        child: Form(
          key: _key,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name' 
                ),
                validator: (e) {
                  if (e.isEmpty) {
                    return 'Please fill your name';
                  }
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email' 
                ),
                validator: (e) {
                  if (e.isEmpty) {
                    return 'Please fill your email';
                  }
                },
              ),
              SizedBox(height: 16.0),
              Container(
                // padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  gradient: LinearGradient(
                    colors: <Color>[
                      Colors.pink,
                      Colors.white,
                      Colors.redAccent
                    ]
                  )
                ),
                child: Center(
                  child: FlatButton(
                    child: Text('Submit'),
                    onPressed: () {
                      if (_key.currentState.validate()) {
                        _key.currentState.save();
                        send();
                      }
                    },
                  ),
                )
              ),
              StreamBuilder<QuerySnapshot>(
                stream: db.collection('AEJ').snapshots(),
                builder: (context, i) {
                  if (i.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: i.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot snapshot = i.data.documents[index];
                        return Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              ListTile(
                                title: Text(snapshot['name']),
                                subtitle: Text(snapshot['email']),
                              ),
                            ],
                          )
                        );
                      },
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}