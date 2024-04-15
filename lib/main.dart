import 'package:chat/divice.dart';
import 'package:chat/firebase_options.dart';
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

  if (isFirstTime) {
    Divice divice = Divice(id: const Uuid().v1());
    prefs.setBool('first_time', false);
    firestore.collection('divice').doc('infoDivice').set(divice.toMap());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Chat(),
    );
  }
}
