class GetReasons {
  bool? success;
  List<GetReasons>? reasons;

  GetReasons({this.success, this.reasons});

  GetReasons.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['reasons'] != null) {
      reasons = <GetReasons>[];
      json['reasons'].forEach((v) {
        reasons!.add(new GetReasons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.reasons != null) {
      data['reasons'] = this.reasons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reasons {
  int? id;
  String? type;
  String? key;
  String? name;
  String? createdAt;
  String? updatedAt;
  bool? selected;

  Reasons(
      {this.id,
        this.type,
        this.key,
        this.name,
        this.createdAt,
        this.updatedAt});

  Reasons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    key = json['key'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['key'] = this.key;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}