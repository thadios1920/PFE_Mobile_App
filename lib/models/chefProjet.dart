class ChefProjet {
  final String id;
  final String imagePath;
  final String nom;
  final String email;
  final String prenom;
  final int numTel;
  final int cin;
  final String password;
  final bool isDarkMode;

  const ChefProjet({
    required this.id,
    required this.imagePath,
    required this.numTel,
    required this.cin,
    required this.password,
    required this.nom,
    required this.email,
    required this.prenom,
    required this.isDarkMode,
  });
}
