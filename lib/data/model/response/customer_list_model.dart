// To parse this JSON data, do
//
//     final customerListModel = customerListModelFromJson(jsonString);

import 'dart:convert';

PaginationCustomerModel customerListModelFromJson(String str) => PaginationCustomerModel.fromJson(json.decode(str));

String customerListModelToJson(PaginationCustomerModel data) => json.encode(data.toJson());

class PaginationCustomerModel {
    int totalSize;
    String limit;
    String offset;
    Data data;

    PaginationCustomerModel({
        required this.totalSize,
        required this.limit,
        required this.offset,
        required this.data,
    });

    factory PaginationCustomerModel.fromJson(Map<String, dynamic> json) => PaginationCustomerModel(
        totalSize: json["total_size"],
        limit: json["limit"],
        offset: json["offset"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "total_size": totalSize,
        "limit": limit,
        "offset": offset,
        "data": data.toJson(),
    };
}

class Data {
    int currentPage;
    List<CustomerModel> data;
    String firstPageUrl;
    int from;
    int lastPage;
    String lastPageUrl;
    List<Link> links;
    String nextPageUrl;
    String path;
    int perPage;
    dynamic prevPageUrl;
    int to;
    int total;

    Data({
        required this.currentPage,
        required this.data,
        required this.firstPageUrl,
        required this.from,
        required this.lastPage,
        required this.lastPageUrl,
        required this.links,
        required this.nextPageUrl,
        required this.path,
        required this.perPage,
        this.prevPageUrl,
        required this.to,
        required this.total,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<CustomerModel>.from(json["data"].map((x) => CustomerModel.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class CustomerModel {
    int id;
    String text;
    String email;
    String? image;
    int isFollowed;

    CustomerModel({
        required this.id,
        required this.text,
        required this.email,
        this.image,
        required this.isFollowed,
    });

    factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
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

class Link {
    String? url;
    String label;
    bool active;

    Link({
        this.url,
        required this.label,
        required this.active,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
    };
}
