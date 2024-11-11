import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApii{
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  Future<void> getTocken() async {

    print("*********************************");
    await messaging.requestPermission();

    final token = await messaging.getToken();
    print(token);

  }
}