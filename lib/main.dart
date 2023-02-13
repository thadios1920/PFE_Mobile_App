import 'package:flutter/material.dart';
import 'pages/signIn.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TimeTracker',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const SignInPage(),
    );
  }
}
