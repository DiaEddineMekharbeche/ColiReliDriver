class Payments {
  bool? status;
  String? message;
  Rapport? rapport;
  List<Details>? details;

  Payments({this.status, this.message, this.rapport, this.details});

  Payments.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    rapport =
    json['rapport'] != null ? new Rapport.fromJson(json['rapport']) : null;
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.rapport != null) {
      data['rapport'] = this.rapport!.toJson();
    }
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rapport {
  int? total;
  int? deliveryFee;
  int? missionId;
  int? captainId;
  int? branchId;
  int? paymentStatus;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? code;

  Rapport(
      {this.total,
        this.deliveryFee,
        this.missionId,
        this.captainId,
        this.branchId,
        this.paymentStatus,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.code});

  Rapport.fromJson(Map<String, dynamic> json) {
    total = json['total']?? 0;
    deliveryFee = json['delivery_fee']?? 0;
    missionId = json['mission_id'] ?? 0;
    captainId = json['captain_id']?? 0;
    branchId = json['branch_id']?? 0;
    paymentStatus = json['payment_status']?? 0;
    updatedAt = json['updated_at']?? '';
    createdAt = json['created_at']?? '';
    id = json['id']?? 0;
    code = json['code']?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['delivery_fee'] = this.deliveryFee;
    data['mission_id'] = this.missionId;
    data['captain_id'] = this.captainId;
    data['branch_id'] = this.branchId;
    data['payment_status'] = this.paymentStatus;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['code'] = this.code;
    return data;
  }
}

class Details {
  String? trackingCode;
  int? cost;
  int? price;
  int? deliveryFee;
  int? amountToBoCollected;
  String? status;

  Details(
      {this.trackingCode,
        this.cost,
        this.price,
        this.deliveryFee,
        this.amountToBoCollected,
        this.status});

  Details.fromJson(Map<String, dynamic> json) {
    trackingCode = json['traking_code']??'';
    cost = json['cost']?? 0;
    price = json['price']?? 0;
    deliveryFee = json['delivery_fee']?? 0;
    amountToBoCollected = json['amount_to_bo_collected']??0;
    status = json['Status']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['traking_code'] = this.trackingCode;
    data['cost'] = this.cost;
    data['price'] = this.price;
    data['delivery_fee'] = this.deliveryFee;
    data['amount_to_bo_collected'] = this.amountToBoCollected;
    data['Status'] = this.status;
    return data;
  }
}