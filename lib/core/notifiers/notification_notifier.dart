import 'package:flutter/material.dart';
import 'package:p_notify/core/api/notificaions_api.dart';
import 'package:p_notify/core/models/notifications.dart';

class NotificaionsNotifier with ChangeNotifier {
  List<NotificationItem> notifications = [];
  bool isLoading = false;
  Future<void> fetchNotifications({required String id}) async {
    try {
      isLoading = true;
      final api = NotificaionApi();
      final r = await api.fetchNotificaions(userID: id);
      notifications = r.notifications ?? [];
      notifyListeners();
      isLoading = false;
    } catch (e) {
      isLoading = false;
    }
  }
}
