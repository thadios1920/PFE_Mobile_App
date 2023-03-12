import 'package:flutter/material.dart';
import 'package:pfe_mobile_app/pages/chefProjet/create_task.dart';
import 'package:pfe_mobile_app/pages/chefProjet/task_details.dart';

import '../../models/tache.dart';
import '../../services/api_Client.dart';

class TodoListPage extends StatefulWidget {
  final idChantier;
  const TodoListPage({super.key, required this.idChantier});

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final _searchController = TextEditingController();
  List<Tache> taches = [];

  @override
  void initState() {
    print("idChantier${widget.idChantier}");
    super.initState();
    getTaches();
  }

  Future<void> getTaches() async {
    taches =
        await ApiClient.getTaches('/chantiers/${widget.idChantier}/taches');

    if (taches.isNotEmpty) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  //  final List<Tache>displayTachesList = List.from(taches);
  void _search(String value) {
    setState(() {
      taches = taches
          .where((element) =>
              element.titre!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  _search(value);
                },
                controller: _searchController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Rechercher une tâche',
                ),
              ),
            ),
            Expanded(
              child: taches.isEmpty
                  ? const Center(
                      child: Text(
                        "Pas de resultat",
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.bold),
                      ),
                    )
                  : ListView.builder(
                      itemCount: taches.length,
                      itemBuilder: (context, index) {
                        final todo = taches[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TodoDetailsPage(
                                  description: todo.description ?? "",
                                  title: todo.titre ?? "",
                                  createdAt: todo.createdAt ?? "",
                                  etat: todo.etat!,
                                  statut: todo.statut!,
                                  type: todo.type!,
                                  updatedAt: todo.updatedAt!,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            child: ListTile(
                              title: Text(todo.titre ?? ""),
                              subtitle: Text(todo.description ?? ''),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreateTask(idChantier: widget.idChantier),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: isPortrait
          ? FloatingActionButtonLocation.centerFloat
          : FloatingActionButtonLocation.endFloat,
    );
  }
}
