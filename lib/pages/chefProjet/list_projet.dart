import 'package:flutter/material.dart';
import 'package:pfe_mobile_app/models/projet.dart';
import 'package:pfe_mobile_app/services/api_Client.dart';

import '../../custom_Widgets/common_Widgets/CardWidget.dart';
import 'list_chantier.dart';

class ListProjet extends StatefulWidget {
  const ListProjet({super.key});

  @override
  State<ListProjet> createState() => _ListProjetState();
}

class _ListProjetState extends State<ListProjet>
    with SingleTickerProviderStateMixin {
  List<Projet> projets = [];
  var isLoaded = false;

  final colorstheme = Color(0xff4b4b87);

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0)
      ..addListener(() {});
    getProjets();
  }

  Future<void> getProjets() async {
    projets = await ApiClient.getProjets('/chefprojets/1/projets');
    setState(() {});

    if (projets.isNotEmpty) {
      isLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Liste des Projets'),
          elevation: 2.0, // shadow dessus la Bare
        ),
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            // Container(
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(20),
            //       color: Colors.grey[300]),
            //   child: TabBar(
            //       isScrollable: true,
            //       indicatorPadding: const EdgeInsets.all(10),
            //       labelColor: Colors.white,
            //       unselectedLabelColor: colorstheme,
            //       labelStyle: const TextStyle(fontSize: 20),
            //       labelPadding: const EdgeInsets.only(
            //           left: 35, right: 35, top: 10, bottom: 10),
            //       indicator: BoxDecoration(
            //           color: colorstheme,
            //           borderRadius: BorderRadius.circular(20)),
            //       controller: _tabController,
            //       tabs: const [
            //         Text('Avancement'),
            //         Text('Terminées'),
            //         Text('Month'),
            //       ]),
            // ),

            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                ),
                itemCount: projets.length,
                itemBuilder: (context, index) {
                  final project = projets[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ListChantier(id: project.id.toString())),
                      );
                    },
                    child: CardWidget(
                      titreProjet: project.nom.toString(),
                      description: project.description.toString(),
                      date_limite: project.lieu.toString(),
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}
