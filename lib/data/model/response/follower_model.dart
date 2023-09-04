import 'store_model.dart';

class Follower {
  int? id;
  int? userId;
  int? storeId;
  String? followedBy;
  int? status;
  int? isBlocked;
  String? createdAt;
  String? updatedAt;
  Store? store;
  User? user;

  Follower(
      {this.id,
      this.userId,
      this.storeId,
      this.followedBy,
      this.status,
      this.isBlocked,
      this.createdAt,
      this.updatedAt,
      this.store,
      this.user});

  Follower.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    storeId = json['store_id'];
    followedBy = json['followed_by'];
    status = json['status'];
    isBlocked = json['is_blocked'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['store_id'] = this.storeId;
    data['followed_by'] = this.followedBy;
    data['status'] = this.status;
    data['is_blocked'] = this.isBlocked;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? image;
  int? isPhoneVerified;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? cmFirebaseToken;
  int? status;
  int? orderCount;
  int? loginMedium;
  int? zoneId;
  String? socialId;
  int? walletBalance;
  int? loyaltyPoint;
  String? refCode;
  String? currentLanguageKey;
  String? refBy;
  String? tempToken;

  User(
      {this.id,
      this.fName,
      this.lName,
      this.phone,
      this.email,
      this.image,
      this.isPhoneVerified,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.cmFirebaseToken,
      this.status,
      this.orderCount,
      this.loginMedium,
      this.socialId,
      this.zoneId,
      this.walletBalance,
      this.loyaltyPoint,
      this.refCode,
      this.currentLanguageKey,
      this.refBy,
      this.tempToken});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    isPhoneVerified = json['is_phone_verified'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cmFirebaseToken = json['cm_firebase_token'];
    status = json['status'];
    orderCount = json['order_count'];
    loginMedium = json['login_medium'];
    socialId = json['social_id'];
    zoneId = json['zone_id'];
    walletBalance = json['wallet_balance'];
    loyaltyPoint = json['loyalty_point'];
    refCode = json['ref_code'];
    currentLanguageKey = json['current_language_key'];
    refBy = json['ref_by'];
    tempToken = json['temp_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['image'] = this.image;
    data['is_phone_verified'] = this.isPhoneVerified;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['cm_firebase_token'] = this.cmFirebaseToken;
    data['status'] = this.status;
    data['order_count'] = this.orderCount;
    data['login_medium'] = this.loginMedium;
    data['social_id'] = this.socialId;
    data['zone_id'] = this.zoneId;
    data['wallet_balance'] = this.walletBalance;
    data['loyalty_point'] = this.loyaltyPoint;
    data['ref_code'] = this.refCode;
    data['current_language_key'] = this.currentLanguageKey;
    data['ref_by'] = this.refBy;
    data['temp_token'] = this.tempToken;
    return data;
  }
}
