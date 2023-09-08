import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:p_notify/core/models/device_identifier_mode.dart';

class DeviceInfoProvider with ChangeNotifier {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<String> deviceIdentifier() async {
    late AndroidDeviceInfo androidInfo;
    late IosDeviceInfo iosInfo;

    if (Platform.isAndroid) {
      androidInfo = await _deviceInfo.androidInfo;
    }
    if (Platform.isIOS) {
      iosInfo = await _deviceInfo.iosInfo;
    }

    final deviceIdentityResponse = DeviceIdentityResponse.fromJson(
      Platform.isAndroid ? androidInfo.data : iosInfo.data,
    );
    final id = Platform.isAndroid
        ? deviceIdentityResponse.id as String
        : deviceIdentityResponse.identifierForVendor as String;
    return id;
  }
}
