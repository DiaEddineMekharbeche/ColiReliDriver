class Driver_fees {
  bool? success;
  DefaultDriverFee? defaultDriverFee;
  List<DriverFees>? driverFees;

  Driver_fees({this.success, this.defaultDriverFee, this.driverFees});

  Driver_fees.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    defaultDriverFee = json['default_driver_fee'] != null
        ? new DefaultDriverFee.fromJson(json['default_driver_fee'])
        : null;
    if (json['driver_fees'] != null) {
      driverFees = <DriverFees>[];
      json['driver_fees'].forEach((v) {
        driverFees!.add(new DriverFees.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.defaultDriverFee != null) {
      data['default_driver_fee'] = this.defaultDriverFee!.toJson();
    }
    if (this.driverFees != null) {
      data['driver_fees'] = this.driverFees!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DefaultDriverFee {
  int? deliveryFee;
  int? returnFee;

  DefaultDriverFee({this.deliveryFee, this.returnFee});

  DefaultDriverFee.fromJson(Map<String, dynamic> json) {
    deliveryFee = json['delivery_fee'];
    returnFee = json['return_fee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['delivery_fee'] = this.deliveryFee;
    data['return_fee'] = this.returnFee;
    return data;
  }
}

class DriverFees {
  int? id;
  int? deliveryFee;
  int? returnFee;
  String? createdAt;
  String? updatedAt;
  Area? area;

  DriverFees(
      {this.id,
        this.deliveryFee,
        this.returnFee,
        this.createdAt,
        this.updatedAt,
        this.area});

  DriverFees.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveryFee = json['delivery_fee'];
    returnFee = json['return_fee'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    area = json['area'] != null ? new Area.fromJson(json['area']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['delivery_fee'] = this.deliveryFee;
    data['return_fee'] = this.returnFee;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.area != null) {
      data['area'] = this.area!.toJson();
    }
    return data;
  }
}

class Area {
  int? id;
  String? name;

  Area({this.id, this.name});

  Area.fromJson(Map<String, dynamic> json) {
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