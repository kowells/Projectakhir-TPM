import 'package:flutter/material.dart';
import 'package:grafimedia/views/login_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'boxes.dart';
import 'models/book_lib.dart';

void main() async {
  // Hive.initFlutter();
  await Hive.initFlutter();
  Hive.registerAdapter(LibAdapter());
  await Hive.openBox<Lib>(HiveBoxes.lib);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const LoginPage(),
    );
  }
}
