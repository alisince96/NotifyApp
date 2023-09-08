import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:p_notify/app/routes/api.routes.dart';
import 'package:p_notify/core/models/login_response.dart';
import 'package:p_notify/core/models/sign_up_response.dart';

class AuthenticationAPI {
  final client = http.Client();
  final headers = {
    // 'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

//User Sign Up
  Future<SignUpResponse> createAccount({
    required String useremail,
    required String username,
    required String userpassword,
  }) async {
    const subUrl = EndPoints.signUp;
    final Uri uri = Uri.parse(EndPoints.baseURL + subUrl);
    final params = {
      "email_or_phone": useremail,
      "password": userpassword,
      "name": username
    };

    final http.Response response = await client.post(
      uri,
      headers: headers,
      body: params,
    );
    final body = response.body;
    return SignUpResponse.fromJson(jsonDecode(body));
  }

  Future<LoginResponse> userLogin({
    required String useremail,
    required String userpassword,
    required String deviceID,
  }) async {
    const subUrl = EndPoints.login;
    final Uri uri = Uri.parse(EndPoints.baseURL + subUrl);
    final http.Response response = await client.post(uri,
        headers: headers,
        body: {
          "email": useremail,
          "password": userpassword,
          "device_token": deviceID
        });
    final body = response.body;
    return LoginResponse.fromJson(jsonDecode(body));
  }
}
