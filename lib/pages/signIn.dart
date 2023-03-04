import 'package:flutter/material.dart';
import 'package:pfe_mobile_app/pages/chefProjet/etage_details.dart';
import 'package:pfe_mobile_app/pages/login_page.dart';

import '../custom_Widgets/sign_in-button.dart';
import '../services/api_Client.dart';
import 'chefProjet/list_projet.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chef de Projet'),
        elevation: 2.0, // shadow dessus la Bare
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Connectez-Vous',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 48.0),
          SignInButton(
            text: ' Entrer vos données ',
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            color: Colors.teal[700],
          ),
          const SizedBox(height: 8.0),
          const Text(
            'Or',
            style: TextStyle(fontSize: 14.0, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0),
          SignInButton(
            text: 'Go Anonymous (Test purpose) ',
            textColor: Colors.black,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ListProjet()),
              );
            },
            color: Colors.lime[300],
          ),
        ],
      ),
    );
  }
}
