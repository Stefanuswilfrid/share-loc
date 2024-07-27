import 'package:flutter/material.dart';

enum NotificationType {
  simple,
  followRequest,
  smylRequest,
}

abstract class NotificationModel {
  late final String id;
  late final String userId;
  late final DateTime timeSent;
  late final String title;
  late final String body;
}

class FollowRequestNotificationModel implements NotificationModel {
  @override
  late final String id;
  @override
  late final String userId;
  @override
  late final DateTime timeSent;
  @override
  late final String title;
  @override
  late final String body;

  late final String requesterId;

  FollowRequestNotificationModel({
    required this.id,
    required this.userId,
    required this.timeSent,
    required this.title,
    required this.body,
    required this.requesterId,
  });
}
