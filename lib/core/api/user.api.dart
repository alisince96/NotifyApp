import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:p_notify/app/routes/api.routes.dart';

class UserAPI {
  final client = http.Client();
// All The API Related to User Information Present Here
  Future getUserData({required String token}) async {
    const subUrl = '/auth/verify';
    final Uri uri = Uri.parse(ApiRoutes.baseurl + subUrl);
    Map<String,String> headers={'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': "*",
        "Authorization": token};
    final http.Response response = await client.get(
      uri,
      headers:headers,
    );
    if (kDebugMode) {
      print("Map Data token "+ token.toLowerCase());
      print("Get Auth User Data"+response.body);
    }
    final dynamic body = response.body;
    return body;
  }

  Future getUserDetails({required String userEmail}) async {
    var subUrl = '/info/$userEmail';
    final Uri uri = Uri.parse(ApiRoutes.baseurl + subUrl);
    final http.Response response = await client.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': "*",
      },
    );
    print("UserResponse"+response.body.toString());
    final dynamic body = response.body;
    return body;
  }

  Future updateUserDetails(
      {required String userEmail,
      required String userAddress,
      required String userPhoneNo}) async {
    const subUrl = '/info/add-user-info';
    final Uri uri = Uri.parse(ApiRoutes.baseurl + subUrl);
    final http.Response response = await client.post(uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Access-Control-Allow-Origin': "*",
        },
        body: jsonEncode({
          "useremail": userEmail,
          "user_address": userAddress,
          "user_phone_no": userPhoneNo,
        }));
    final dynamic body = response.body;
    return body;
  }

  Future changePassword(
      {required String userEmail,
      required String oluserpassword,
      required String newuserpassword}) async {
    const subUrl = '/auth/change-password';
    final Uri uri = Uri.parse(ApiRoutes.baseurl + subUrl);
    final http.Response response = await client.post(uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Access-Control-Allow-Origin': "*",
        },
        body: jsonEncode({
          "oluserpassword": oluserpassword,
          "useremail": userEmail,
          "newuserpassword": newuserpassword
        }));
    final dynamic body = response.body;
    return body;
  }
}