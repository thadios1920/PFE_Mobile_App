class Chantier {
  int? id;
  String? nom;
  String? description;
  String? dateDebut;
  String? dateFin;
  String? createdAt;
  String? updatedAt;
  int? projetId;

  Chantier(
      {this.id,
      this.nom,
      this.description,
      this.dateDebut,
      this.dateFin,
      this.createdAt,
      this.updatedAt,
      this.projetId});

  Chantier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    description = json['description'];
    dateDebut = json['date_debut'];
    dateFin = json['date_fin'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    projetId = json['ProjetId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['nom'] = nom;
    data['description'] = description;
    data['date_debut'] = dateDebut;
    data['date_fin'] = dateFin;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['ProjetId'] = projetId;
    return data;
  }

  static List<Chantier> chantierFromJSON(List projetJSON) {
    return projetJSON.map((data) {
      return Chantier.fromJson(data);
    }).toList();
  }
}
