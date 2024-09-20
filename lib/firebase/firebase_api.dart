import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../controllers/notification/notification_settrings_controller.dart';
import '../models/notification/notification_model.dart';
import '../views/notifaicatio/notifaication_view_page.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  final notificationTitle = message.notification?.title ?? "No title";
  final notificationBody = message.notification?.body ?? "No body";
  final dataPayload = message.data;

  print('Title: $notificationTitle');
  print('Body: $notificationBody');
  print('Payload: $dataPayload');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  // final _tokenKey = 'fcm_token';
  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.max,
    playSound: true,
    enableVibration: true,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();
  final NotificationSettingsController settingsController =
      Get.find<NotificationSettingsController>();

  void handleMessage(RemoteMessage? message) async {
    if (message == null) return;
    final notificationTitle = message.notification?.title ?? "No title";
    final notificationBody = message.notification?.body ?? "No body";

    final newNotification = NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      notificationAbout: notificationTitle,
      notificationMessage: notificationBody,
      notificationTime: DateTime.now(),
    );

    settingsController.notificationsList.add(newNotification);
    // Handle new notification (e.g., add to a list)
    // Navigate to the notification view
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.to(() => NotificationView(
          notificationsList: settingsController.notificationsList));
    });
  }

  Future initLocalNotifications() async {
    const android =
        AndroidInitializationSettings('@drawable/launch_background');
    const settings = InitializationSettings(android: android);
    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        final message = RemoteMessage.fromMap(jsonDecode(response.payload!));
        handleMessage(message);
      },
    );
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> initPushNotification() async {
    final isVibrationEnabled = settingsController.vibrationEnabled.value;
    final isSoundEnabled = settingsController.soundEnabled.value;
    final isFlashLightEnabled = settingsController.flashLightEnabled.value;

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: isSoundEnabled,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      if (isVibrationEnabled || isSoundEnabled || isFlashLightEnabled) {
        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@drawable/launch_background',
              importance: Importance.max,
              priority: Priority.high,
              playSound: isSoundEnabled,
              vibrationPattern: isVibrationEnabled
                  ? Int64List.fromList([0, 500, 1000])
                  : null,
            ),
          ),
          payload: jsonEncode(message.toMap()),
        );
      }
    });
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    if (fCMToken != null) {
      print('saved token: $fCMToken');
    }
    print('Token: ${fCMToken!}');
    await initPushNotification();
    await initLocalNotifications();
  }
}
