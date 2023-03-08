import 'package:flutter/material.dart';
import 'package:pfe_mobile_app/models/chefChantier.dart';
import 'package:pfe_mobile_app/models/tache.dart';

import '../../services/api_Client.dart';

class CreateTask extends StatefulWidget {
  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  List<ChefChantier> chefChantiers = [];

  final _formKey = GlobalKey<FormState>();
  final _titreController = TextEditingController();
  final _descriptionController = TextEditingController();
  // String _selectedPriority = "ChefsChantiers";
  @override
  void initState() {
    super.initState();
    getChefChantiers();

    print("chefs:${chefChantiers.length}");
  }

  Future<void> getChefChantiers() async {
    print("getchefchantiers");
    chefChantiers = await ApiClient.getChefChantier('/chefchantiers');

    if (chefChantiers.isNotEmpty) {
      setState(() {});
      print("chefschantier:${chefChantiers.length}");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Methode pour ajouter une tache
    createTask(Tache tache) async {
      await ApiClient.ajouterTache('/taches/1/1', tache);
      setState(() {});
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Ajouter Tache'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  const Text(
                    'Titre',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: _titreController,
                    decoration: const InputDecoration(
                      hintText: 'Enter le titre de la tache',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un titre';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      hintText: 'Entrer la description du tache',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer une description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Priority',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // DropdownButton<String>(
                  //   value: _selectedPriority,
                  //   onChanged: (newValue) {
                  //     setState(() {
                  //       _selectedPriority = newValue!;
                  //     });
                  //   },
                  //   items: <String>['Low', 'Medium', 'High']
                  //       .map<DropdownMenuItem<String>>((String value) {
                  //     return DropdownMenuItem<String>(
                  //       value: value,
                  //       child: Text(value),
                  //     );
                  //   }).toList(),
                  // ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          Tache tache = Tache(
                              titre: _titreController.text.toString(),
                              description:
                                  _descriptionController.text.toString(),
                              type: "normal",
                              statut: false,
                              etat: false);

                          await createTask(tache);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Tâche ajoutée avec succès')));
                        }
                      },
                      child: const Text('Ajouter Tache'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
