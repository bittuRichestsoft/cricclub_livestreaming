import 'package:cricclub_livestreaming/screens/live_stream.dart';
import 'package:cricclub_livestreaming/screens/match_join_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'screens/auth/login_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
var size = MediaQuery.of(navigatorKey.currentContext!).size;
late SharedPreferences prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: prefs.getBool("isLogin") != null && prefs.getBool("isLogin")!
          ? CameraExampleHome()
          : CameraExampleHome(),
      /*home: prefs.getBool("isLogin") != null && prefs.getBool("isLogin")!
          ? MatchJoinScreen()
          : LoginPage(),*/
    );
  }
}
