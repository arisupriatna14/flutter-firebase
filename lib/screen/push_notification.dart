import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotification extends StatefulWidget {
  PushNotification({Key key}) : super(key: key);

  _PushNotificationState createState() => _PushNotificationState();
}

class _PushNotificationState extends State<PushNotification> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _token;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.getToken().then((String token) {
      setState(() {
        _token = token;
      });
      print('=========Token=======');
      print(_token);
    });
    _firebaseMessaging.configure();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Push Notification'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Push Notification'),
          onPressed: () {},
        ),
      ),
    );
  }
}