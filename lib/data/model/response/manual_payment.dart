class ManualPayment {
  int? id;
  int? modelId;
  int? userId;
  String? modelName;
  String? type;
  int? isAccepted;
  int? isRejected;
  String? desc;
  String? image;
  int? amount;
  String? createdAt;
  String? updatedAt;

  ManualPayment(
      {this.id,
      this.modelId,
      this.userId,
      this.modelName,
      this.type,
      this.isAccepted,
      this.isRejected,
      this.desc,
      this.image,
      this.amount,
      this.createdAt,
      this.updatedAt});

  ManualPayment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelId = json['model_id'];
    userId = json['user_id'];
    modelName = json['model_name'];
    type = json['type'];
    isAccepted = json['is_accepted'];
    isRejected = json['is_rejected'];
    desc = json['desc'];
    image = json['image'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['model_id'] = this.modelId;
    data['user_id'] = this.userId;
    data['model_name'] = this.modelName;
    data['type'] = this.type;
    data['is_accepted'] = this.isAccepted;
    data['is_rejected'] = this.isRejected;
    data['desc'] = this.desc;
    data['image'] = this.image;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
