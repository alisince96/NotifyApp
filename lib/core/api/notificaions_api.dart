import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:p_notify/app/routes/api.routes.dart';
import 'package:p_notify/core/models/notifications.dart';

class NotificaionApi {
  final client = http.Client();
  final headers = {
    // 'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<Notifications> fetchNotificaions({
    required String userID,
  }) async {
    final subUrl = '/api/v2/notifications/list?user_id=$userID';
    final Uri uri = Uri.parse(ApiRoutes.baseurl + subUrl);
    final http.Response response = await client.get(uri, headers: headers);
    final body = response.body;
    return Notifications.fromJson(jsonDecode(body));
  }
}
