class User {
  final String email;
  final String? password;
  final String? name;
  final bool? isPremium;
  final DateTime? createdAt;

  User({
    required this.email,
    this.password,
    this.name,
    this.isPremium,
    this.createdAt,
  });
}
