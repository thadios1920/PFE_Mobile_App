import 'package:flutter/material.dart';
import 'package:pfe_mobile_app/pages/chefProjet/chefProjetHome.dart';
import 'package:pfe_mobile_app/pages/chefProjet/create_task.dart';
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
      // theme: ThemeData(primaryColor: const Color(0xFF334a5c)),
      home: const Scaffold(
        body: ChefProjetHome(),
        // bottomNavigationBar: BottomNavigationBar(items: const [
        //   BottomNavigationBarItem(icon: Icon(Icons.home), label: "Projets"),
        //   BottomNavigationBarItem(icon: Icon(Icons.add), label: "Taches"),
        // ]),
      ),
    );
  }
}
