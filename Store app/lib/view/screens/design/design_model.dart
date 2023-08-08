class User {
  final String name;
  final String username;
  final String profileImage;

  User({required this.name, required this.username, required this.profileImage});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      username: json['username'],
      profileImage: json['profileImage'],
    );
  }
}