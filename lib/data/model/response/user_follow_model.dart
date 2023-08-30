class UserFollow {
  int? id;
  String? text;
  String? email;
  String? image;
  int? isFollowed;

  UserFollow({this.id, this.text, this.email, this.image, this.isFollowed});

  UserFollow.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    email = json['email'];
    image = json['image'];
    isFollowed = json['is_followed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['email'] = this.email;
    data['image'] = this.image;
    data['is_followed'] = this.isFollowed;
    return data;
  }
}
