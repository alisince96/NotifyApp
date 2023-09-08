import 'package:p_notify/core/models/single_prod.dart';

class ProdModel {
  List<ProdData>? data;
  bool? success;
  int? status;

  ProdModel({this.data, this.success, this.status});

  ProdModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProdData>[];
      json['data'].forEach((v) {
        data!.add(new ProdData.fromJson(v));
      });
    }
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['status'] = this.status;
    return data;
  }
}

class Links {
  String? details;

  Links({this.details});

  Links.fromJson(Map<String, dynamic> json) {
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['details'] = this.details;
    return data;
  }
}
