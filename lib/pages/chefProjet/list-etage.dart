import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pfe_mobile_app/image.dart';
import 'package:pfe_mobile_app/models/chantier.dart';
import '../../models/element.dart' as element;

import '../../custom_Widgets/posts_carousel.dart';
import '../../models/etage.dart';
import '../../models/plan.dart';
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
  List<Plan> planList = [];

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
    setState(() {});

    if (etagesList.isNotEmpty) {
      await getPlans();
    }
  }

// Fonction qui remplie une liste des plans des etages
  Future<void> getPlans() async {
    try {
      // print(etagesList.length);
      for (var i = 0; i < etagesList.length; i++) {
        // print("in the loop");
        Plan plan = await ApiClient.getPlan("/etages/${etagesList[i].id}/plan");
        // print('plan:$plan');
        planList[i] = plan;
      }
    } catch (e) {
      print(e);
    }

    setState(() {});

    if (elementsList.isNotEmpty) {
      isLoaded = true;
    }
  }

  // Future<void> getElements() async {
  //   elementsList = await ApiClient.getElements("/etages/$id/elements");
  //   try {
  //     // print(etagesList.length);
  //     for (var i = 0; i < etagesList.length; i++) {
  //       // print("in the loop");
  //       List<element.Element> element = await ApiClient.getElements("/etages/${etagesList[i].id}/plan");
  //       // print('plan:$plan');
  //       elementsList[i] = element;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }

  //   setState(() {});

  //   if (elementsList.isNotEmpty) {
  //     isLoaded = true;
  //   }
  // }

  // _build() {
  //   return Scaffold(
  //     body: SingleChildScrollView(
  //         child: Center(
  //       child: ListView.builder(
  //         scrollDirection: Axis.vertical,
  //         shrinkWrap: true,
  //         itemCount: etagesList.length,
  //         itemBuilder: (context, index) {
  //           return GestureDetector(
  //             onTap: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => ImageZoningPage()),
  //               );
  //             },
  //             child: Container(
  //               height: 100,
  //               width: 100,
  //               color: Colors.grey,
  //               child: Center(
  //                   child: Image.network(planList[index].imageUrl ?? "")),
  //             ),
  //           );
  //         },
  //       ),
  //     )),
  //   );
  // }

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
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildListEtage();
  }
}
