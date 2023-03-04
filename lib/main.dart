import 'package:flutter/material.dart';
import 'package:pfe_mobile_app/pages/login_page.dart';
import 'pages/signIn.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MAS',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: Scaffold(
        body: LoginScreen(),
        // bottomNavigationBar: BottomNavigationBar(items: const [
        //   BottomNavigationBarItem(icon: Icon(Icons.home), label: "Projets"),
        //   BottomNavigationBarItem(icon: Icon(Icons.add), label: "Taches"),
        // ]),
      ),
    );
  }
}
