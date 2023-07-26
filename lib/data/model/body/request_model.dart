/*class FriendRequest {
  final User sender;
  RequestStatus status;

  FriendRequest({required this.sender, this.status = RequestStatus.pending});
}*/

class User {
  String name;
  String username;
  String profileImage;

  User(
      {
        required this.name,
        required this.username,
        required this.profileImage,
      });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      username: json['username'],
      profileImage: json['profileImage'],
    );

  /*Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['name'] = name!;
    data['Username'] = username!;
    data['ProfileImage'] = profileImage!;
    return data;*/
  }
}