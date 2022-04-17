class Keys {
  bool? success;
  List<Type>? reasons;

  Keys({this.success, this.reasons});

  Keys.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['reasons'] != null) {
      reasons = <Type>[];
      json['reasons'].forEach((v) {
        reasons!.add(new Type.fromJson(v));
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

class Type {
  String? origin;
  String? translation;

  Type({this.origin, this.translation});

  Type.fromJson(Map<String, dynamic> json) {
    origin = json['origin'];
    translation = json['translation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['origin'] = this.origin;
    data['translation'] = this.translation;
    return data;
  }
}