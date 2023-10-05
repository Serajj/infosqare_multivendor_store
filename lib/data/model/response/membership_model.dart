class Membership {
  int? id;
  String? title;
  String? desc;
  String? benifits;
  int? price;
  String? type;
  String? createdAt;
  String? updatedAt;
  String? period;

  Membership(
      {this.id,
      this.title,
      this.desc,
      this.benifits,
      this.price,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.period});

  Membership.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    benifits = json['benifits'];
    price = json['price'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    period = json['period'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['benifits'] = this.benifits;
    data['price'] = this.price;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['period'] = this.period;
    return data;
  }
}
