import 'package:chat/firebase_options.dart';
import 'package:chat/models/device.dart';
import 'package:chat/screens/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final prefs = await SharedPreferences.getInstance();
  final isFirstTime = prefs.getBool('first_time') ?? true;

  String deviceId;

  if (isFirstTime) {
    deviceId = const Uuid().v1();
    prefs.setString('device_id', deviceId);
    prefs.setBool('first_time', false);

    Device device = Device(id: deviceId);
    firestore.collection('device').doc(deviceId).set(device.toMap());
  } else {
    deviceId = prefs.getString('device_id') ?? 'unknown';
  }

  runApp(MyApp(deviceId: deviceId));
}

class MyApp extends StatelessWidget {
  final String deviceId;
  MyApp({Key? key, required this.deviceId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Chat(deviceId: deviceId),
    );
  }
}
