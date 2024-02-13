import 'package:cricclub_livestreaming/screens/auth/login_page.dart';
import 'package:cricclub_livestreaming/screens/match_join_screen.dart';
import 'package:cricclub_livestreaming/utils/common_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class FirebaseService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signUp(String name, String email, String password) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> login(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() async {
    await auth.signOut().then((value) {
      prefs.setBool("isLogin", false);
      showSnackBar("Logged out Successfully");
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
    }).onError((error, stackTrace) {
      showSnackBar(error.toString());
    });
  }
}
