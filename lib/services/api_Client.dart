import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/chantier.dart';
import '../models/projet.dart';

var client = http.Client();
const String baseUrl = "http://192.168.1.17:8080";

class ApiClient {
  // GET method retourne les projet du chef projet inscrit
  static Future<List<Projet>> getProjets(String api) async {
    var url = Uri.parse(baseUrl + api);
    var response = await http.get(url);

    // print("response ${jsonDecode(response.body)}");

    var data = jsonDecode(response.body);
    List tempList = [];
    for (var v in data) {
      tempList.add(v);
    }
    return Projet.projetFromJSON(tempList);
  }

  // GET method retourne les projet du chef projet inscrit
  static Future<List<Chantier>> getChantiers(String api) async {
    var url = Uri.parse(baseUrl + api);
    var response = await http.get(url);

    // print("response ${jsonDecode(response.body)}");

    var data = jsonDecode(response.body);
    List tempList = [];
    for (var v in data) {
      tempList.add(v);
    }
    return Chantier.chantierFromJSON(tempList);
  }
}
