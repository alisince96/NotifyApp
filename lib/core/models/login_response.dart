import 'dart:convert';

class LoginResponse {
  bool? result;
  String? message;
  String? accessToken;
  String? tokenType;
  String? expiresAt;
  User? user;

  LoginResponse({
    this.result,
    this.message,
    this.accessToken,
    this.tokenType,
    this.expiresAt,
    this.user,
  });
  LoginResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message']?.toString();
    accessToken = json['access_token']?.toString();
    tokenType = json['token_type']?.toString();
    expiresAt = json['expires_at']?.toString();
    user = (json['user'] != null) ? User.fromJson(json['user']) : null;
  }
  LoginResponse.toJson() {
    Map<String, dynamic> data = {};
    data['result'] = result;
    data['message'] = message.toString();
    data['access_token'] = accessToken.toString();
    data['token_type'] = tokenType;
    data['expires_at'] = expiresAt;
    data['user'] = user?.toJson();
  }
}

class User {
  int? id;
  String? type;
  String? name;
  String? email;
  String? avatar;
  String? avatarOriginal;
  String? phone;

  User({
    this.id,
    this.type,
    this.name,
    this.email,
    this.avatar,
    this.avatarOriginal,
    this.phone,
  });
  User.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    type = json['type']?.toString();
    name = json['name']?.toString();
    email = json['email']?.toString();
    avatar = json['avatar']?.toString();
    avatarOriginal = json['avatar_original']?.toString();
    phone = json['phone']?.toString();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'name': name,
      'email': email,
      'avatar': avatar,
      'avatarOriginal': avatarOriginal,
      'phone': phone,
    };
  }

  /// will return user in the form of String
  String toJson() => json.encode(toMap());

  /// convert user from string to map then [User]
  static User toUser(String source) => User.fromJson(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, type: $type, name: $name, email: $email, avatar: $avatar, avatarOriginal: $avatarOriginal, phone: $phone)';
  }
}
