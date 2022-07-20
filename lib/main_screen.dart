import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_notifications/localization_provider.dart';
import 'package:local_notifications/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // AndroidInitializationSettings? androidInitializationSettings;
  // IOSInitializationSettings? iosInitializationSettings;
  // InitializationSettings? initializationSettings;
  // FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  // NotificationDetails? notificationDetails;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   androidInitializationSettings =
  //       AndroidInitializationSettings('ic_launcher.png');
  //   iosInitializationSettings = IOSInitializationSettings();
  //   initializationSettings = InitializationSettings(
  //       android: androidInitializationSettings, iOS: iosInitializationSettings);
  //   flutterLocalNotificationsPlugin!.initialize(initializationSettings!,
  //       onSelectNotification: (n) {
  //     setState(() {});
  //   });

  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('1', 'myNotification');
  //   const IOSNotificationDetails iosNotificationDetails =
  //       IOSNotificationDetails();

  //   notificationDetails = const NotificationDetails(
  //       android: androidNotificationDetails, iOS: iosNotificationDetails);
  // }

  // _notifyMe() async {
  //   await flutterLocalNotificationsPlugin!.show(
  //       1,
  //       'My First Notification title',
  //       'My First Notification body',
  //       notificationDetails);
  // }

  AndroidInitializationSettings? androidInitializationSettings;
  IOSInitializationSettings? iosInitializationSettings;
  InitializationSettings? initializationSettings;
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    androidInitializationSettings = const AndroidInitializationSettings(
      'ic_launcher',
    );
    iosInitializationSettings = const IOSInitializationSettings();
    initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    flutterLocalNotificationsPlugin!.initialize(initializationSettings!,
        onSelectNotification: (payload) {
      //
    });
  }

  Future<void> notifyMe() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channelId',
      'title',
      importance: Importance.high,
      priority: Priority.max,
    );

    IOSNotificationDetails iosNotificationDetails =
        const IOSNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);

    await flutterLocalNotificationsPlugin!
        .show(1, 'title', 'body', notificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.app_title.tr()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 250.0,
              height: 300,
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 155, 30, 30),
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Color.fromARGB(255, 15, 141, 19),
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    FlickerAnimatedText('Made with 💝\nBY SHAZLYCODE'),
                  ],
                  onTap: () {
                    print("Tap Event");
                  },
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  notifyMe();
                },
                child: Text(LocaleKeys.notify_me_btn.tr().toUpperCase())),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      // context.locale = Locale('en');
                      context
                          .read<LocalizationsProvider>()
                          .selectEnglish(context);
                    },
                    child: Text("English".toUpperCase())),
                ElevatedButton(
                    onPressed: () async {
                      // context.locale = Locale('ar');
                      context
                          .read<LocalizationsProvider>()
                          .selectArabic(context);
                    },
                    child: Text("العربية"))
              ],
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
