class UserData {
    int id;
    String text;
    String email;
    String? image;
    int isFollowed;

    UserData({
        required this.id,
        required this.text,
        required this.email,
        this.image,
        required this.isFollowed,
    });

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        text: json["text"],
        email: json["email"],
        image: json["image"],
        isFollowed: json["is_followed"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "email": email,
        "image": image,
        "is_followed": isFollowed,
    };
}