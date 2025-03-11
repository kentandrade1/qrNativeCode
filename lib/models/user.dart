class User {
  int? id;
  String username;

  User({this.id, required this.username});

  // Convertir a Map para insertar en SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
    };
  }

  // Convertir de Map a objeto User
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
    );
  }
}
