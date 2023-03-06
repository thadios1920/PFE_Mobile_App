import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pfe_mobile_app/image.dart';
import 'package:pfe_mobile_app/models/chantier.dart';
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
  late TabController _tabController;
  late PageController _pageController;

  Chantier chantier = Chantier();
  List<element.Element> elementsList = [];
  List<Etage> etagesList = [];
  List planList = [];

  String id = "";
  var isLoaded = false;

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

  Future<List<element.Element>> getElements(i) async {
    // try {

    List<element.Element> elementlist =
        await ApiClient.getElements("/etages/${etagesList[i].id}/elements");
    setState(() {});
    return elementlist;
    // } catch (e) {
    //   print(e);
    // }

    if (elementsList.isNotEmpty) {
      isLoaded = true;
    }
  }

  _build() {
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: planList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ImageZoningPage(
                            idEtage: etagesList[index].id!,
                          )),
                );
              },
              child: Container(
                height: 100,
                width: 100,
                color: Colors.grey,
                child: Center(
                    child: Image.network(planList[index]['imageUrl'] ?? "")),
                // child: Text("plan")),
              ),
            );
          },
        ),
      )),
    );
  }

  _buildListEtage() {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white10,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          chantier.nom ?? "",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 10.0,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorWeight: 3.0,
          // labelColor: Theme.of(context).primaryColor,
          labelStyle: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 18.0,
          ),
          tabs: const <Widget>[
            Tab(text: 'Les etages'),
            Tab(text: 'Ajouter une tache'),
          ],
        ),
        // systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      // drawer: CustomDrawer(),
      body: ListView(
        children: <Widget>[
          // FollowingUsers(),
          PostsCarousel(
            pageController: _pageController,
            title: 'Etages',
            etages: etagesList,
            plans: planList,
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) => ImageZoningPage(),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildListEtage();
  }
}
