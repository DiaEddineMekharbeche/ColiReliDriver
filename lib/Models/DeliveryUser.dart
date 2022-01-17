import 'package:colireli_delivery/Models/Mission.dart';

class DeliveryUser {
  String? apiToken;
  String? tokenType;
  String? expiresAt;
  User? user;
  Current_Mission? currentMission;

  DeliveryUser(
      {this.apiToken,
        this.tokenType,
        this.expiresAt,
        this.user,
        this.currentMission});

  DeliveryUser.fromJson(Map<String, dynamic> json) {
    apiToken = json['api_token'];
    tokenType = json['token_type'];
    expiresAt = json['expires_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    currentMission = json['current_mission'] != null
        ? new Current_Mission.fromJson(json['current_mission'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_token'] = this.apiToken;
    data['token_type'] = this.tokenType;
    data['expires_at'] = this.expiresAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.currentMission != null) {
      data['current_mission'] = this.currentMission!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? type;
  String? name;
  String? email;
  String? avatar;
  String? avatarOriginal;
  String? address;
  String? country;
  String? city;
  String? postalCode;
  String? phone;
  String? balance;

  User(
      {this.id,
        this.type,
        this.name,
        this.email,
        this.avatar,
        this.avatarOriginal,
        this.address,
        this.country,
        this.city,
        this.postalCode,
        this.phone,
        this.balance});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
    avatarOriginal = json['avatar_original'];
    address = json['address'];
    country = json['country'];
    city = json['city'];
    postalCode = json['postal_code'];
    phone = json['phone'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    data['avatar_original'] = this.avatarOriginal;
    data['address'] = this.address;
    data['country'] = this.country;
    data['city'] = this.city;
    data['postal_code'] = this.postalCode;
    data['phone'] = this.phone;
    data['balance'] = this.balance;
    return data;
  }
}
class Current_Mission {
  int? id;
  String? code;
  String? type;
  String? amount;
  String? captainId;
  String? address;
  String? state;
  String? area;
  String? order;
  String? createdAt;
  String? updatedAt;
  String? statusId;
  String? clientId;
  String? dueDate;
  String? fromBranchId;
  String? toBranchId;
  String? segImg;
  String? otp;

  Current_Mission(
      {this.id,
        this.code,
        this.type,
        this.amount,
        this.captainId,
        this.address,
        this.state,
        this.area,
        this.order,
        this.createdAt,
        this.updatedAt,
        this.statusId,
        this.clientId,
        this.dueDate,
        this.fromBranchId,
        this.toBranchId,
        this.segImg,
        this.otp});

  Current_Mission.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    type = json['type'];
    amount = json['amount'];
    captainId = json['captain_id'];
    address = json['address'];
    state = json['state'];
    area = json['area'];
    order = json['order'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    statusId = json['status_id'];
    clientId = json['client_id'];
    dueDate = json['due_date'];
    fromBranchId = json['from_branch_id'];
    toBranchId = json['to_branch_id'];
    segImg = json['seg_img'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['captain_id'] = this.captainId;
    data['address'] = this.address;
    data['state'] = this.state;
    data['area'] = this.area;
    data['order'] = this.order;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status_id'] = this.statusId;
    data['client_id'] = this.clientId;
    data['due_date'] = this.dueDate;
    data['from_branch_id'] = this.fromBranchId;
    data['to_branch_id'] = this.toBranchId;
    data['seg_img'] = this.segImg;
    data['otp'] = this.otp;
    return data;
  }
}