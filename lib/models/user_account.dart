class UserAccount {
  const UserAccount({
    required this.name,
    required this.email,
    required this.passwordHash,
  });

  final String name;
  final String email;
  final String passwordHash;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'passwordHash': passwordHash,
    };
  }

  factory UserAccount.fromJson(Map<String, dynamic> json) {
    return UserAccount(
      name: json['name'] as String,
      email: json['email'] as String,
      passwordHash: json['passwordHash'] as String,
    );
  }
}
