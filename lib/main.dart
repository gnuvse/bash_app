import 'package:bash_app/views/home_screen.dart';
import 'package:flutter/material.dart';



main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello world',
      home: HomeScreen(),
    );
  }
}
