class Colis {
  bool? success;
  String? message;
  List<Data>? data;

  Colis({this.success, this.message, this.data});

  Colis.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? code;
  int? statusId;
  int? paymentStatus;
  String? type;
  int? branchId;
  String? shippingDate;
  int? clientId;
  String? clientAddress;
  int? paymentType;
  int? paid;
  int? paymentIntegrationId;
  int? paymentMethodId;
  int? tax;
  int? insurance;
  String? deliveryTime;
  int? shippingCost;
  int? cost;
  int? totalWeight;
  int? employeeUserId;
  String? clientStreetAddressMap;
  String? clientLat;
  String? clientLng;
  String? clientUrl;
  String? reciverStreetAddressMap;
  String? reciverLat;
  String? reciverLng;
  String? reciverUrl;
  String? attachmentsBeforeShipping;
  String? attachmentsAfterShipping;
  String? clientPhone;
  String? reciverPhone;
  int? otp;
  String? createdAt;
  String? updatedAt;
  String? reciverName;
  String? reciverAddress;
  int? missionId;
  int? captainId;
  int? returnCost;
  int? fromCountryId;
  int? fromStateId;
  int? fromAreaId;
  int? toCountryId;
  int? toStateId;
  int? toAreaId;
  String? prevBranch;
  int? fromBranchId;
  int? toBranchId;
  int? clientStatus;
  int? amountToBeCollected;
  String? orderId;
  String? barcode;
  int? containerId;
  int? reportDriverId;
  int? reportShipmentId;
  int? clientReportId;
  Pay? pay;
  FromAddress? fromAddress;
  State? state;
  State? area;
  bool? isSelected = false;
  List<Description>? reasons;

  Data(
      {this.id,
        this.code,
        this.statusId,
        this.paymentStatus,
        this.type,
        this.branchId,
        this.shippingDate,
        this.clientId,
        this.clientAddress,
        this.paymentType,
        this.paid,
        this.paymentIntegrationId,
        this.paymentMethodId,
        this.tax,
        this.insurance,
        this.deliveryTime,
        this.shippingCost,
        this.cost,
        this.totalWeight,
        this.employeeUserId,
        this.clientStreetAddressMap,
        this.clientLat,
        this.clientLng,
        this.clientUrl,
        this.reciverStreetAddressMap,
        this.reciverLat,
        this.reciverLng,
        this.reciverUrl,
        this.attachmentsBeforeShipping,
        this.attachmentsAfterShipping,
        this.clientPhone,
        this.reciverPhone,
        this.otp,
        this.createdAt,
        this.updatedAt,
        this.reciverName,
        this.reciverAddress,
        this.missionId,
        this.captainId,
        this.returnCost,
        this.fromCountryId,
        this.fromStateId,
        this.fromAreaId,
        this.toCountryId,
        this.toStateId,
        this.toAreaId,
        this.prevBranch,
        this.fromBranchId,
        this.toBranchId,
        this.clientStatus,
        this.amountToBeCollected,
        this.orderId,
        this.barcode,
        this.containerId,
        this.reportDriverId,
        this.reportShipmentId,
        this.clientReportId,
        this.pay,
        this.fromAddress,
        this.state,
        this.area,
        this.reasons});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] ;
    code = json['code'];
    statusId = json['status_id'];
    paymentStatus = json['payment_status'];
    type = json['type'];
    branchId = json['branch_id'];
    shippingDate = json['shipping_date'];
    clientId = json['client_id'];
    clientAddress = json['client_address'];
    paymentType = json['payment_type'];
    paid = json['paid'];
    paymentIntegrationId = json['payment_integration_id'];
    paymentMethodId = json['payment_method_id'];
    tax = json['tax'];
    insurance = json['insurance'];
    deliveryTime = json['delivery_time'];
    shippingCost = json['shipping_cost'];
    cost = json['cost'];
    totalWeight = json['total_weight'];
    employeeUserId = json['employee_user_id'];
    clientStreetAddressMap = json['client_street_address_map'];
    clientLat = json['client_lat'];
    clientLng = json['client_lng'];
    clientUrl = json['client_url'];
    reciverStreetAddressMap = json['reciver_street_address_map'];
    reciverLat = json['reciver_lat'];
    reciverLng = json['reciver_lng'];
    reciverUrl = json['reciver_url'];
    attachmentsBeforeShipping = json['attachments_before_shipping'];
    attachmentsAfterShipping = json['attachments_after_shipping'];
    clientPhone = json['client_phone'];
    reciverPhone = json['reciver_phone'];
    otp = json['otp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    reciverName = json['reciver_name'];
    reciverAddress = json['reciver_address'];
    missionId = json['mission_id'];
    captainId = json['captain_id'];
    returnCost = json['return_cost'];
    fromCountryId = json['from_country_id'];
    fromStateId = json['from_state_id'];
    fromAreaId = json['from_area_id'];
    toCountryId = json['to_country_id'];
    toStateId = json['to_state_id'];
    toAreaId = json['to_area_id'];
    prevBranch = json['prev_branch'];
    fromBranchId = json['from_branch_id'];
    toBranchId = json['to_branch_id'];
    clientStatus = json['client_status'];
    amountToBeCollected = json['amount_to_be_collected'];
    orderId = json['order_id'];
    barcode = json['barcode'];
    containerId = json['container_id'];
    reportDriverId = json['reportDriver_id'];
    reportShipmentId = json['reportShipment_id'];
    clientReportId = json['clientReport_id'];
    pay = json['pay'] != null ? new Pay.fromJson(json['pay']) : null;
    fromAddress = json['from_address'] != null
        ? new FromAddress.fromJson(json['from_address'])
        : null;
    state = json['state'] != null ? new State.fromJson(json['state']) : null;
    area = json['area'] != null ? new State.fromJson(json['area']) : null;
    if (json['reasons'] != null) {
      reasons = <Description>[];
      json['reasons'].forEach((v) {
        reasons!.add(new Description.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['status_id'] = this.statusId;
    data['payment_status'] = this.paymentStatus;
    data['type'] = this.type;
    data['branch_id'] = this.branchId;
    data['shipping_date'] = this.shippingDate;
    data['client_id'] = this.clientId;
    data['client_address'] = this.clientAddress;
    data['payment_type'] = this.paymentType;
    data['paid'] = this.paid;
    data['payment_integration_id'] = this.paymentIntegrationId;
    data['payment_method_id'] = this.paymentMethodId;
    data['tax'] = this.tax;
    data['insurance'] = this.insurance;
    data['delivery_time'] = this.deliveryTime;
    data['shipping_cost'] = this.shippingCost;
    data['cost'] = this.cost;
    data['total_weight'] = this.totalWeight;
    data['employee_user_id'] = this.employeeUserId;
    data['client_street_address_map'] = this.clientStreetAddressMap;
    data['client_lat'] = this.clientLat;
    data['client_lng'] = this.clientLng;
    data['client_url'] = this.clientUrl;
    data['reciver_street_address_map'] = this.reciverStreetAddressMap;
    data['reciver_lat'] = this.reciverLat;
    data['reciver_lng'] = this.reciverLng;
    data['reciver_url'] = this.reciverUrl;
    data['attachments_before_shipping'] = this.attachmentsBeforeShipping;
    data['attachments_after_shipping'] = this.attachmentsAfterShipping;
    data['client_phone'] = this.clientPhone;
    data['reciver_phone'] = this.reciverPhone;
    data['otp'] = this.otp;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['reciver_name'] = this.reciverName;
    data['reciver_address'] = this.reciverAddress;
    data['mission_id'] = this.missionId;
    data['captain_id'] = this.captainId;
    data['return_cost'] = this.returnCost;
    data['from_country_id'] = this.fromCountryId;
    data['from_state_id'] = this.fromStateId;
    data['from_area_id'] = this.fromAreaId;
    data['to_country_id'] = this.toCountryId;
    data['to_state_id'] = this.toStateId;
    data['to_area_id'] = this.toAreaId;
    data['prev_branch'] = this.prevBranch;
    data['from_branch_id'] = this.fromBranchId;
    data['to_branch_id'] = this.toBranchId;
    data['client_status'] = this.clientStatus;
    data['amount_to_be_collected'] = this.amountToBeCollected;
    data['order_id'] = this.orderId;
    data['barcode'] = this.barcode;
    data['container_id'] = this.containerId;
    data['reportDriver_id'] = this.reportDriverId;
    data['reportShipment_id'] = this.reportShipmentId;
    data['clientReport_id'] = this.clientReportId;
    if (this.pay != null) {
      data['pay'] = this.pay!.toJson();
    }
    if (this.fromAddress != null) {
      data['from_address'] = this.fromAddress!.toJson();
    }
    if (this.state != null) {
      data['state'] = this.state!.toJson();
    }
    if (this.area != null) {
      data['area'] = this.area!.toJson();
    }
    if (this.reasons != null) {
      data['reasons'] = this.reasons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pay {
  int? id;
  String? type;
  String? value;
  String? key;
  String? lang;
  String? name;
  String? createdAt;
  String? updatedAt;

  Pay(
      {this.id,
        this.type,
        this.value,
        this.key,
        this.lang,
        this.name,
        this.createdAt,
        this.updatedAt});

  Pay.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    value = json['value'];
    key = json['key'];
    lang = json['lang'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['value'] = this.value;
    data['key'] = this.key;
    data['lang'] = this.lang;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class FromAddress {
  int? id;
  int? clientId;
  String? address;
  int? countryId;
  int? stateId;
  int? areaId;
  String? clientStreetAddressMap;
  String? clientLat;
  String? clientLng;
  String? clientUrl;
  String? createdAt;
  String? updatedAt;

  FromAddress(
      {this.id,
        this.clientId,
        this.address,
        this.countryId,
        this.stateId,
        this.areaId,
        this.clientStreetAddressMap,
        this.clientLat,
        this.clientLng,
        this.clientUrl,
        this.createdAt,
        this.updatedAt});

  FromAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    address = json['address'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    areaId = json['area_id'];
    clientStreetAddressMap = json['client_street_address_map'];
    clientLat = json['client_lat'];
    clientLng = json['client_lng'];
    clientUrl = json['client_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['address'] = this.address;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['area_id'] = this.areaId;
    data['client_street_address_map'] = this.clientStreetAddressMap;
    data['client_lat'] = this.clientLat;
    data['client_lng'] = this.clientLng;
    data['client_url'] = this.clientUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class State {
  int? id;
  String? name;

  State({this.id, this.name});

  State.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Description {
  int? id;
  int? shipmentId;
  String? type;
  String? description;

  Description({this.id, this.shipmentId, this.type, this.description});

  Description.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shipmentId = json['shipment_id'];
    type = json['type'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shipment_id'] = this.shipmentId;
    data['type'] = this.type;
    data['description'] = this.description;
    return data;
  }
}