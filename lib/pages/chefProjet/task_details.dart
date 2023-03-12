import 'package:flutter/material.dart';

class TodoDetailsPage extends StatelessWidget {
  final String title;
  final String description;
  final String type;
  final bool etat;
  final bool statut;
  final String createdAt;
  final String updatedAt;

  TodoDetailsPage({
    required this.title,
    required this.description,
    required this.type,
    required this.etat,
    required this.statut,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallDevice = size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de la tâche'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: isSmallDevice ? 24 : 32),
              ),
              SizedBox(height: isSmallDevice ? 16 : 32),
              Text(
                description,
                style: TextStyle(fontSize: isSmallDevice ? 16 : 24),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Type :'),
                      SizedBox(height: 8),
                      Text('Etat :'),
                      SizedBox(height: 8),
                      Text('Statut :'),
                      SizedBox(height: 8),
                      Text('Créé le :'),
                      SizedBox(height: 8),
                      Text('Mis à jour le :'),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(type),
                      const SizedBox(height: 8),
                      Text(etat ? 'Terminée' : 'En cours'),
                      const SizedBox(height: 8),
                      Text(statut ? 'Urgent' : 'Normal'),
                      const SizedBox(height: 8),
                      Text(createdAt),
                      const SizedBox(height: 8),
                      Text(updatedAt),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
