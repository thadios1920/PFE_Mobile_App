import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pfe_mobile_app/image.dart';
import 'package:pfe_mobile_app/models/chantier.dart';
import 'package:pfe_mobile_app/pages/chefProjet/taskListPage.dart';
import '../../models/element.dart' as element;

import '../../custom_Widgets/posts_carousel.dart';
import '../../models/etage.dart';
import '../../services/api_Client.dart';

class ListEtage extends StatefulWidget {
  final Chantier chantier;
  const ListEtage({super.key, required this.chantier});

  @override
  State<ListEtage> createState() => _ListEtageState();
}

class _ListEtageState extends State<ListEtage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late TabController _tabController;
  late PageController _pageController;

  List<element.Element> elementsList = [];
  List<Etage> etagesList = [];
  List planList = [];

  String id = "";
  var isLoaded = false;
  setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    id = widget.chantier.id.toString();
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
    getEtages();
  }

  Future<void> getEtages() async {
    etagesList = await ApiClient.getEtages("/chantiers/$id/etages");

    if (etagesList.isNotEmpty) {
      await getPlans();
      // await getElements();
      setState(() {});
    }
  }

  Future<void> getPlans() async {
    try {
      for (var i = 0; i < etagesList.length; i++) {
        var plan = await ApiClient.getPlan("/etages/${etagesList[i].id}/plan");

        setState(() {
          planList.add(plan);
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    if (elementsList.isNotEmpty) {
      isLoaded = true;
    }
  }

// Fonction qui remplie une liste des plans des etages

  // Future<List<element.Element>> getElements(i) async {
  //   // try {

  //   List<element.Element> elementlist =
  //       await ApiClient.getElements("/etages/${etagesList[i].id}/elements");
  //   setState(() {});
  //   return elementlist;
  //   // } catch (e) {
  //   //   print(e);
  //   // }

  //   if (elementsList.isNotEmpty) {
  //     isLoaded = true;
  //   }
  // }

  _buildListEtage() {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          widget.chantier.nom ?? "",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 10.0,
          ),
        ),

        // systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      // drawer: CustomDrawer(),
      body: [
        ListView(
          children: <Widget>[
            // FollowingUsers(),
            PostsCarousel(
              pageController: _pageController,
              title: 'Etages',
              etages: etagesList,
              plans: planList,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ImageZoningPage(),
                  ),
                );
              },
            ),
          ],
        ),
        TodoListPage(idChantier: widget.chantier.id.toString())
      ][_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setCurrentIndex(index);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Plans"),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: "Taches"),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildListEtage();
  }
}
