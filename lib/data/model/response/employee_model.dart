class Employee {
  int? id;
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? image;
  int? employeeRoleId;
  int? vendorId;
  int? storeId;
  int? status;
  String? firebaseToken;
  String? createdAt;
  String? updatedAt;
  int? isLoggedIn;
  Role? role;

  Employee(
      {this.id,
      this.fName,
      this.lName,
      this.phone,
      this.email,
      this.image,
      this.employeeRoleId,
      this.vendorId,
      this.storeId,
      this.status,
      this.firebaseToken,
      this.createdAt,
      this.updatedAt,
      this.isLoggedIn,
      this.role});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    employeeRoleId = json['employee_role_id'];
    vendorId = json['vendor_id'];
    storeId = json['store_id'];
    status = json['status'];
    firebaseToken = json['firebase_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isLoggedIn = json['is_logged_in'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['image'] = this.image;
    data['employee_role_id'] = this.employeeRoleId;
    data['vendor_id'] = this.vendorId;
    data['store_id'] = this.storeId;
    data['status'] = this.status;
    data['firebase_token'] = this.firebaseToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_logged_in'] = this.isLoggedIn;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    return data;
  }
}

class Role {
  int? id;
  String? name;
  String? modules;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? storeId;
  List<Translations>? translations;

  Role(
      {this.id,
      this.name,
      this.modules,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.storeId,
      this.translations});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    modules = json['modules'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    storeId = json['store_id'];
    if (json['translations'] != null) {
      translations = <Translations>[];
      json['translations'].forEach((v) {
        translations!.add(new Translations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['modules'] = this.modules;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['store_id'] = this.storeId;
    if (this.translations != null) {
      data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Translations {
  int? id;
  String? translationableType;
  int? translationableId;
  String? locale;
  String? key;
  String? value;
  String? createdAt;
  String? updatedAt;

  Translations(
      {this.id,
      this.translationableType,
      this.translationableId,
      this.locale,
      this.key,
      this.value,
      this.createdAt,
      this.updatedAt});

  Translations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    translationableType = json['translationable_type'];
    translationableId = json['translationable_id'];
    locale = json['locale'];
    key = json['key'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['translationable_type'] = this.translationableType;
    data['translationable_id'] = this.translationableId;
    data['locale'] = this.locale;
    data['key'] = this.key;
    data['value'] = this.value;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
