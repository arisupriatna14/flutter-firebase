import 'package:flutter/material.dart';
import 'package:workshop_flutter/screen/firestore_screen.dart';
import 'package:workshop_flutter/screen/login_screen.dart';
import 'package:workshop_flutter/screen/push_notification.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirestoreDB(),
    );
  }
}