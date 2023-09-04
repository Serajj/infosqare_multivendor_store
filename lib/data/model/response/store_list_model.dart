import 'dart:convert';

class StoreList {
  int id;
  String name;
  String phone;
  String email;
  String logo;
  String latitude;
  String longitude;
  String address;
  dynamic footerText;
  int minimumOrder;
  dynamic comission;
  bool scheduleOrder;
  int status;
  int isFollowing;
  int vendorId;
  DateTime createdAt;
  DateTime updatedAt;
  bool freeDelivery;
  String coverPhoto;
  bool delivery;
  bool takeAway;
  bool itemSection;
  double tax;
  int zoneId;
  bool reviewsSection;
  bool active;
  String offDay;
  int selfDeliverySystem;
  bool posSystem;
  int minimumShippingCharge;
  String deliveryTime;
  int veg;
  int nonVeg;
  int orderCount;
  int totalOrder;
  int moduleId;
  int orderPlaceToScheduleInterval;
  int featured;
  int perKmShippingCharge;
  bool prescriptionOrder;
  String slug;
  int? maximumShippingCharge;
  bool cutlery;
  int open;
  double distance;
  int isFollowed;
  int avgRating;
  int ratingCount;
  int positiveRating;
  bool gstStatus;
  String gstCode;
  dynamic discount;
  List<Translation> translations;

  StoreList({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.logo,
    required this.latitude,
    required this.longitude,
    required this.isFollowing,
    required this.address,
    this.footerText,
    required this.minimumOrder,
    this.comission,
    required this.scheduleOrder,
    required this.status,
    required this.vendorId,
    required this.createdAt,
    required this.updatedAt,
    required this.freeDelivery,
    required this.coverPhoto,
    required this.delivery,
    required this.takeAway,
    required this.itemSection,
    required this.tax,
    required this.zoneId,
    required this.reviewsSection,
    required this.active,
    required this.offDay,
    required this.selfDeliverySystem,
    required this.posSystem,
    required this.minimumShippingCharge,
    required this.deliveryTime,
    required this.veg,
    required this.nonVeg,
    required this.orderCount,
    required this.totalOrder,
    required this.moduleId,
    required this.orderPlaceToScheduleInterval,
    required this.featured,
    required this.perKmShippingCharge,
    required this.prescriptionOrder,
    required this.slug,
    this.maximumShippingCharge,
    required this.cutlery,
    required this.open,
    required this.distance,
    required this.isFollowed,
    required this.avgRating,
    required this.ratingCount,
    required this.positiveRating,
    required this.gstStatus,
    required this.gstCode,
    this.discount,
    required this.translations,
  });

  factory StoreList.fromJson(Map<String, dynamic> json) => StoreList(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        logo: json["logo"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        address: json["address"],
        footerText: json["footer_text"],
        minimumOrder: json["minimum_order"],
        comission: json["comission"],
        scheduleOrder: json["schedule_order"],
        status: json["status"],
        isFollowing: json["is_followed"] ?? 0,
        vendorId: json["vendor_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        freeDelivery: json["free_delivery"],
        coverPhoto: json["cover_photo"],
        delivery: json["delivery"],
        takeAway: json["take_away"],
        itemSection: json["item_section"],
        tax: json["tax"]?.toDouble(),
        zoneId: json["zone_id"],
        reviewsSection: json["reviews_section"],
        active: json["active"],
        offDay: json["off_day"],
        selfDeliverySystem: json["self_delivery_system"],
        posSystem: json["pos_system"],
        minimumShippingCharge: json["minimum_shipping_charge"],
        deliveryTime: json["delivery_time"],
        veg: json["veg"],
        nonVeg: json["non_veg"],
        orderCount: json["order_count"],
        totalOrder: json["total_order"],
        moduleId: json["module_id"],
        orderPlaceToScheduleInterval: json["order_place_to_schedule_interval"],
        featured: json["featured"],
        perKmShippingCharge: json["per_km_shipping_charge"],
        prescriptionOrder: json["prescription_order"],
        slug: json["slug"],
        maximumShippingCharge: json["maximum_shipping_charge"],
        cutlery: json["cutlery"],
        open: json["open"],
        distance: json["distance"]?.toDouble(),
        isFollowed: json["is_followed"],
        avgRating: json["avg_rating"],
        ratingCount: json["rating_count"],
        positiveRating: json["positive_rating"],
        gstStatus: json["gst_status"],
        gstCode: json["gst_code"],
        discount: json["discount"],
        translations: List<Translation>.from(
            json["translations"].map((x) => Translation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "logo": logo,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "footer_text": footerText,
        "minimum_order": minimumOrder,
        "comission": comission,
        "schedule_order": scheduleOrder,
        "status": status,
        "vendor_id": vendorId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "free_delivery": freeDelivery,
        "cover_photo": coverPhoto,
        "delivery": delivery,
        "take_away": takeAway,
        "item_section": itemSection,
        "tax": tax,
        "zone_id": zoneId,
        "reviews_section": reviewsSection,
        "active": active,
        "off_day": offDay,
        "self_delivery_system": selfDeliverySystem,
        "pos_system": posSystem,
        "minimum_shipping_charge": minimumShippingCharge,
        "delivery_time": deliveryTime,
        "veg": veg,
        "non_veg": nonVeg,
        "order_count": orderCount,
        "total_order": totalOrder,
        "module_id": moduleId,
        "order_place_to_schedule_interval": orderPlaceToScheduleInterval,
        "featured": featured,
        "per_km_shipping_charge": perKmShippingCharge,
        "prescription_order": prescriptionOrder,
        "slug": slug,
        "maximum_shipping_charge": maximumShippingCharge,
        "cutlery": cutlery,
        "open": open,
        "distance": distance,
        "is_followed": isFollowed,
        "avg_rating": avgRating,
        "rating_count": ratingCount,
        "positive_rating": positiveRating,
        "gst_status": gstStatus,
        "gst_code": gstCode,
        "discount": discount,
        "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
      };
}

class Translation {
  int id;
  String translationableType;
  int translationableId;
  String locale;
  String key;
  String value;
  dynamic createdAt;
  dynamic updatedAt;

  Translation({
    required this.id,
    required this.translationableType,
    required this.translationableId,
    required this.locale,
    required this.key,
    required this.value,
    this.createdAt,
    this.updatedAt,
  });

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        id: json["id"],
        translationableType: json["translationable_type"],
        translationableId: json["translationable_id"],
        locale: json["locale"],
        key: json["key"],
        value: json["value"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "translationable_type": translationableType,
        "translationable_id": translationableId,
        "locale": locale,
        "key": key,
        "value": value,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
