import 'package:flutter/material.dart';
import 'package:pfe_mobile_app/custom_Widgets/common_Widgets/ChantierItem.dart';

import '../../models/chantier.dart';
import '../../services/api_Client.dart';

class ListChantier extends StatefulWidget {
  final String id;
  const ListChantier({super.key, required this.id});

  @override
  State<ListChantier> createState() => _ListChantierState();
}

class _ListChantierState extends State<ListChantier> {
  String id = '';
  List<Chantier> chantiers = [];
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    id = widget.id;
    getProjets();
  }

  Future<void> getProjets() async {
    chantiers = await ApiClient.getChantiers("/projets/$id/chantiers");
    setState(() {});

    if (chantiers.isNotEmpty) {
      isLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Liste des Chantiers'),
          elevation: 2.0, // shadow dessus la Bare
        ),
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: chantiers.length,
                itemBuilder: (context, index) {
                  final chantier = chantiers[index];
                  return GestureDetector(
                    // onTap: () {
                    //   null;
                    // },
                    child: ChantierItem(
                      nom: chantier.nom.toString(),
                      description: chantier.description.toString(),
                      onTap: () {},
                      // date_limite: project.lieu.toString(),
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}
