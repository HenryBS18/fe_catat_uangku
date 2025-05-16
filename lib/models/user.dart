class User {
  final String email;
  final String password;
  final String? name;

  User({required this.email, required this.password, this.name});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      if (name != null) 'name': name,
    };
  }
}
