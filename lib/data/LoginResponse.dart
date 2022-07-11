class ApiLoginResponse {
  bool? success;
  LoginData? data;
  String? message;
  String? error;

  ApiLoginResponse({this.success, this.data, this.message});

  ApiLoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
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

  ApiLoginResponse.withError(String errorMessage) {
    error = errorMessage;
  }
}

class LoginData {
  String? username;
  String? accessToken;
  String? tokenType;

  LoginData({this.username, this.accessToken, this.tokenType});

  LoginData.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    return data;
  }
}
