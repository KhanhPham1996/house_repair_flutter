class ApiWagResponse {
  bool? success;
  Wage? data;
  String? message;
  String? error;

  ApiWagResponse({this.success, this.data, this.message});

  ApiWagResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Wage.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
  ApiWagResponse.withError(String errorMessage) {
    error = errorMessage;
  }

}

class Wage {
  int? id;
  String? name;
  String? image;
  String? createdAt;
  String? updatedAt;

  Wage({this.id, this.name, this.image, this.createdAt, this.updatedAt});

  Wage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}