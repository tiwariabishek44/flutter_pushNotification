import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:locnotification/local_notifications.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    listenToNotifications();
    super.initState();
  }

//  to listen to any notification clicked or not
  listenToNotifications() {
    log("Listening to notification");
    LocalNotifications.onClickNotification.stream.listen((event) {
      log("This is the notification evet " + event);
      Navigator.pushNamed(context, '/another', arguments: event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter    ")),
      body: Container(
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 200,
                child: Image.network(
                    'https://www.online-image-editor.com/online-image-editor-logo.png'),
              ),
              SizedBox(
                height: 200,
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.timer_outlined),
                onPressed: () {
                  LocalNotifications.showScheduleNotification(
                      title: "Thisi",
                      body: "This is a Periodic Notification",
                      payload: "This is periodic data");
                },
                label: Text("Periodic Notifications"),
              ),

              // to close periodic notifications

              ElevatedButton.icon(
                  icon: Icon(Icons.delete_forever_outlined),
                  onPressed: () {
                    LocalNotifications.cancelAll();
                  },
                  label: Text("Cancel All Notifcations"))
            ],
          ),
        ),
      ),
    );
  }
}
