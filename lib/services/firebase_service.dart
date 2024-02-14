import 'package:cricclub_livestreaming/screens/auth/login_page.dart';
import 'package:cricclub_livestreaming/screens/match_join_screen.dart';
import 'package:cricclub_livestreaming/utils/common_widgets.dart';
import 'package:cricclub_livestreaming/utils/global_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class FirebaseService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signUp(String name, String email, String password) async {
    if (await GlobalUtility().isConnected()) {
      try {
        await auth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
          showSnackBar("Account Created Successfully");
          prefs.setBool("isLogin", true);
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (_) => MatchJoinScreen()), (route) => false);
        });
      } on FirebaseAuthException catch (error) {
        debugPrint("auth exception: ${error.code}");
        switch (error.code) {
          case "email-already-exists":
            showSnackBar("Email already exists");
            break;
          case "invalid-email":
            showSnackBar("Email is Invalid");
            break;
          default:
            showSnackBar("We got an error while creating your account");
            break;
        }
      }
    } else {
      showSnackBar("Internet is not connected");
    }
  }

  Future<void> login(String email, String password) async {
    if (await GlobalUtility().isConnected()) {
      try {
        await auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
          showSnackBar("Login Successfully");
          prefs.setBool("isLogin", true);

          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (_) => MatchJoinScreen()), (route) => false);
        });
      } on FirebaseAuthException catch (error) {
        debugPrint("auth exception: ${error.code}");
        switch (error.code) {
          case "invalid-credential":
            showSnackBar("Invalid Credentials");
            break;
          default:
            showSnackBar("Login error");
            break;
        }
      }
    } else {
      showSnackBar("Internet is not connected");
    }
  }

  Future<void> logout() async {
    if (await GlobalUtility().isConnected()) {
      await auth.signOut().then((value) {
        prefs.setBool("isLogin", false);
        showSnackBar("Logged out Successfully");
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
      }).onError((error, stackTrace) {
        showSnackBar(error.toString());
      });
    } else {
      showSnackBar("Internet is not connected");
    }
  }
}
