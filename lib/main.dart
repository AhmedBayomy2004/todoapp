import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:todoapp/models/models.dart';
import 'package:todoapp/view/home.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskmodelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 246, 247, 249),
        body: Home(),
      ),
    );
  }
}
