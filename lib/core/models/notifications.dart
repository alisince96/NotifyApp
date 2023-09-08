class NotificationItem {
  int? id;
  int? userId;
  int? productId;
  String? notificationText;
  String? createdAt;
  String? updatedAt;

  NotificationItem({
    this.id,
    this.userId,
    this.productId,
    this.notificationText,
    this.createdAt,
    this.updatedAt,
  });
  NotificationItem.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    userId = json['user_id']?.toInt();
    productId = json['product_id']?.toInt();
    notificationText = json['notification_text']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }
}

class Notifications {
  List<NotificationItem>? notifications;

  Notifications({this.notifications});
  Notifications.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      final v = json['notifications'];
      final arr0 = <NotificationItem>[];
      v.forEach((v) {
        arr0.add(NotificationItem.fromJson(v));
      });
      notifications = arr0;
    }
  }
}
