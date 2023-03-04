import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pfe_mobile_app/models/projet.dart';
import 'package:pfe_mobile_app/pages/chefProjet/list_chantier.dart';

import '../../custom_Widgets/bar_chart.dart';
import '../../helpers/color_helper.dart';
import '../../services/api_Client.dart';

class ListProjet extends StatefulWidget {
  @override
  _ListProjetState createState() => _ListProjetState();
}

class _ListProjetState extends State<ListProjet> {
  List<Projet> projets = [];
  var isLoaded = false;
  @override
  void initState() {
    super.initState();

    getProjets();
  }

  Future<void> getProjets() async {
    projets = await ApiClient.getProjets('/chefprojets/1/projets');
    setState(() {});

    if (projets.isNotEmpty) {
      isLoaded = true;
    }
  }

  final rand = Random();

  final List<double> weeklySpending = [10, 15, 25, 14, 45, 12, 78];

  _buildCategory(Projet projet, double totalAmountSpent) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ListChantier(projet: projet),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        padding: const EdgeInsets.all(20.0),
        height: 100.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  projet.nom!,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // Text(
                //   '\$${projet.createdAt} / \$${projet.endDate}',
                //   style: const TextStyle(
                //     fontSize: 18.0,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 10.0),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double maxBarWidth = constraints.maxWidth;
                const double percent = 50;

                double barWidth = percent * maxBarWidth;

                if (barWidth < 0) {
                  barWidth = 0;
                }
                return Stack(
                  children: <Widget>[
                    Container(
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    Container(
                      height: 20.0,
                      width: barWidth,
                      decoration: BoxDecoration(
                        color: getColor(context, percent),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            forceElevated: true,
            floating: true,

            // pinned: true,
            expandedHeight: 100.0,
            leading: IconButton(
              icon: const Icon(Icons.settings),
              iconSize: 30.0,
              onPressed: () {},
            ),
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('Les Projets'),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add),
                iconSize: 30.0,
                onPressed: () {},
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index == 0) {
                  return Container(
                    margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 6.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: BarChart(weeklySpending),
                  );
                } else {
                  final Projet projet = projets[index - 1];
                  // category.expenses?.forEach((Expense expense) {
                  //   totalAmountSpent += expense.cost;
                  // });
                  return _buildCategory(projet, 2);
                }
              },
              childCount: 1 + projets.length,
            ),
          ),
        ],
      ),
    );
  }
}
