import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pfe_mobile_app/models/plan.dart';

import '../models/chantier.dart';
import '../models/etage.dart';
import '../models/projet.dart';
import '../models/element.dart' as element;

var client = http.Client();
const String baseUrl = "http://192.168.1.12:8080";

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

  // GET method retourne les projet du chef projet inscrit
  static Future<List<Etage>> getEtages(String api) async {
    var url = Uri.parse(baseUrl + api);
    var response = await http.get(url);

    // print("response ${jsonDecode(response.body)}");

    var data = jsonDecode(response.body);
    List tempList = [];
    for (var v in data) {
      tempList.add(v);
    }
    return Etage.etageFromJSON(tempList);
  }

  // GET method retourne les projet du chef projet inscrit
  static Future<List<element.Element>> getElements(String api) async {
    var url = Uri.parse(baseUrl + api);
    var response = await http.get(url);

    // print("response ${jsonDecode(response.body)}");

    var data = jsonDecode(response.body);
    List tempList = [];
    for (var v in data) {
      tempList.add(v);
    }
    return element.Element.elementFromJSON(tempList);
  }

  // GET method retourne les projet du chef projet inscrit
  static Future<Plan> getPlan(String api) async {
    var url = Uri.parse(baseUrl + api);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Plan.planFromJSON(data);
    } else {
      throw Exception('Failed to load Plan');
    }
  }

  //*******Post Requests */

  static affecterDonnesElement(String api, element.Element element) async {
    var url = Uri.parse(baseUrl + api);
    var response = await http.put(url, body: jsonEncode(element.toJson()));

    return jsonDecode(response.body);
  }
}
