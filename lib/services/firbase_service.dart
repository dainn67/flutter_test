import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:routing_app/services/log_service.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print(message.notification?.title);
  print(message.notification?.body);
  print(message.data);
}

class FirebaseService {
  const FirebaseService._();

  static final _firebaseMessaging = FirebaseMessaging.instance;

  static final remoteConfig = FirebaseRemoteConfig.instance;

  static Future<void> init() async {
    await _initNotification();
    await _initRemoteConfig();
  }

  static _initRemoteConfig() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));

    // await remoteConfig.setDefaults(const {
    //   'test': true,
    //   'number': 10,
    // });
  }

  static _initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  static Future<void> logEvent({required String name, Map<String, Object>? params}) async {
    try {
      await FirebaseAnalytics.instance.logEvent(name: name, parameters: params);
    } catch (e) {
      printError('Firebase event: $e');
    }
  }
}
