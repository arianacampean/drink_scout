final String UserTable = "users";

class UserFileds {
  static final String id = "id";
  static final String username = "username";
  static final String parola = "parola";
  static final String tip = "tip";
}

class User {
  int? id;
  String username;
  String parola;
  String tip;
  User(
      {this.id,
      required this.username,
      required this.parola,
      required this.tip});
}
