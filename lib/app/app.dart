import 'package:flutter/material.dart';

import '../features/splash/splash_screen.dart';


class OjoApp extends StatefulWidget {
  const OjoApp({super.key});

  @override
  State<OjoApp> createState() => _OjoAppState();
}

class _OjoAppState extends State<OjoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xff080A15),
      ),
    );
  }
}
