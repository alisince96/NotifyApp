// ignore_for_file: avoid_print, recursive_getters

import 'dart:io';

import 'package:cache_manager/cache_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:p_notify/app/constants/app.keys.dart';
import 'package:p_notify/app/routes/app.routes.dart';
import 'package:p_notify/core/api/authentication.api.dart';
import 'package:p_notify/core/models/login_response.dart';
import 'package:p_notify/core/utils/snackbar.util.dart';

class AuthenticationNotifier with ChangeNotifier {
  final AuthenticationAPI _authenticationAPI = AuthenticationAPI();
  String? userId;
  String? userEmail;
  String? _passwordLevel = "";
  String? get passwordLevel => _passwordLevel;

  String? _passwordEmoji = "";
  String? get passwordEmoji => _passwordEmoji;
  bool isLoading = false;
// Check the Password is the Password is weak or strong
  void checkPasswordStrength({required String password}) {
    String mediumPattern = r'^(?=.*?[!@#\$&*~]).{8,}';
    String strongPattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

    if (password.contains(RegExp(strongPattern))) {
      _passwordEmoji = '🚀';
      _passwordLevel = 'Strong';
      notifyListeners();
    } else if (password.contains(RegExp(mediumPattern))) {
      _passwordEmoji = '🔥';
      _passwordLevel = 'Medium';
      notifyListeners();
    } else if (!password.contains(RegExp(strongPattern))) {
      _passwordEmoji = '😢';
      _passwordLevel = 'Weak';
      notifyListeners();
    }
  }
// Calling this function to create account in databasee
  Future<void> createAccount({
    required String useremail,
    required BuildContext context,
    required String username,
    required String userpassword,
  }) async {
    try {
      var userData = await _authenticationAPI.createAccount(
          useremail: useremail, username: username, userpassword: userpassword);

      bool isAuthenticated =
          (userData.result ?? false) && userData.userId != null;

      if (isAuthenticated) {
        Navigator.of(context).pushReplacementNamed(AppRouter.loginRoute);
        ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
            text: 'Congratulations, you can login now', context: context));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
            text: userData.message ?? '', context: context));
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
          text: 'Oops No You Need A Good Internet Connection',
          context: context));
    } catch (e) {
      print(e);
    }
  }
// On Login Button Click this function is trigger and User can login in the app
  Future<void> userLogin({
    required String useremail,
    required BuildContext context,
    required String userpassword,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      final id = await FirebaseMessaging.instance.getToken();
      var userData = await _authenticationAPI.userLogin(
        useremail: useremail,
        userpassword: userpassword,
        deviceID: id ?? '',
      );
      print(userData.accessToken);
      userId = userData.user?.id.toString() ?? '';
      userEmail = useremail.toString();
      print('userId: $userId');
      print('token: $id');

      bool isAuthenticated = userData.result ?? false;

      if (isAuthenticated) {
        WriteCache.setString(key: AppKeys.id, value: userId ?? '');
      
        WriteCache.setString(key: "Username", value: useremail);
        WriteCache.setString(
                key: AppKeys.userData, value: LoginResponse.toJson().toString())
            .whenComplete(
          () => Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute),
        );
        isLoading = false;
        notifyListeners();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
            text: userData.message ?? '', context: context));
        isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
          text: 'Oops No You Need A Good Internet Connection',
          context: context));
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      isLoading = false;
      notifyListeners();
    }
  }
}
