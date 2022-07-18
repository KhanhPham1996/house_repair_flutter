import 'package:my_ft_app/data/BaseApiResponse.dart';



class LoginData  extends Serializable{
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
