import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:test_app/network_pack.dart';
import 'package:test_app/view/onboard/onboard.dart';
import 'package:test_app/wifi_list.dart';

Future<void> notify() async {
  try {

    // ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
    //   content: Text('Yay! A SnackBar!'),
    // ));
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'basic_notification',
          title: 'TestApp',
          body: 'Trial local notification in background',
        ));

  } catch (e) {
    print(e.toString());
  }
}

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  await AwesomeNotifications().initialize(
      'resource://drawable/app_icon',
      [
        NotificationChannel(
            channelKey: 'basic_notification',
            channelName: 'FitJerk Motivation',
            channelDescription: "FitJerk Today Notification ",
            defaultColor: Colors.blue,
            importance: NotificationImportance.High,
            ledColor: Colors.white,
            playSound: true,
            enableLights: true,
            enableVibration: true
        )
      ]);

  // await AndroidAlarmManager.periodic(const Duration(minutes: 1), 1, notify,
  //
  //     startAt: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 8, 30),
  //     exact: true, wakeup: true, allowWhileIdle: true, rescheduleOnReboot: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test_app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      ///this one will be uncommented///
      // home: const OnBoard(),
     // home: FlutterWifiIoT(),
       home: const NetworkPack(),
    );
  }
}


