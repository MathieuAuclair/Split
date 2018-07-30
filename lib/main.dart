import 'package:flutter/material.dart';
import 'package:split_app/interface/StartupMenu.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'An awesome app to keep track of your group spent',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new StartupMenu(),
    );
  }
}

