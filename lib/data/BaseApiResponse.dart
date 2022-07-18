import 'dart:convert';

import 'ErrorResponse.dart';

class BaseApiResponse<T extends Serializable> {
  bool? success;
  T? data;
  String? message;
  ErrorResponse? error;

  BaseApiResponse({this.success, this.message,  this.data});

  factory BaseApiResponse.fromJson(Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    return BaseApiResponse<T>(
      success: json["success"],
      message: json["message"],
      data: create(json["data"]),
    );
  }
  BaseApiResponse.withError(Map<String, dynamic>? json) {
    if(json!=null){
      error =  ErrorResponse.fromJson(json);

    }

  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

abstract class Serializable {
  Map<String, dynamic> toJson();
}