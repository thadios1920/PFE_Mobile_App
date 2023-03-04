class Element {
  int? id;
  String? hauteur;
  String? largeur;
  String? type;
  String? nom;
  String? matiere;
  int? etageId;

  Element({
    this.id,
    this.hauteur,
    this.nom,
    this.matiere,
    this.type,
    this.etageId,
    this.largeur,
  });

  Element.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hauteur = json['hauteur'];
    largeur = json['largeur'];
    matiere = json['matiere'];
    etageId = json['EtageId'];
    nom = json['nom'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['hauteur'] = hauteur;
    data['largeur'] = largeur;
    data['nom'] = nom;
    data['type'] = type;
    data['matiere'] = matiere;
    data['EtageId'] = etageId;

    return data;
  }

  static List<Element> elementFromJSON(List elementJSON) {
    return elementJSON.map((data) {
      return Element.fromJson(data);
    }).toList();
  }
}
