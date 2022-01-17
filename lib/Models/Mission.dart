import 'Coli.dart';

class Mission {
  int? id;
  int? shipmentId;
  int? missionId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  Coli? shipment;
  bool? isSelected = false;

  Mission(
      {this.id,
        this.shipmentId,
        this.missionId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.shipment});

  Mission.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shipmentId = json['shipment_id'];
    missionId = json['mission_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    shipment = json['shipment'] != null
        ? new Coli.fromJson(json['shipment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shipment_id'] = this.shipmentId;
    data['mission_id'] = this.missionId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.shipment != null) {
      data['shipment'] = this.shipment!.toJson();
    }
    return data;
  }
}

