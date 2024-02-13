import 'package:cricclub_livestreaming/screens/auth/login_page.dart';
import 'package:cricclub_livestreaming/services/firebase_service.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../utils/app_constants/app_color.dart';

class MatchJoinScreen extends StatefulWidget {
  const MatchJoinScreen({super.key});

  @override
  State<MatchJoinScreen> createState() => _MatchJoinScreenState();
}

class _MatchJoinScreenState extends State<MatchJoinScreen> {
  var clubIdController = TextEditingController();
  var matchIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(size.width * 0.04),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: OutlinedButton(
                    onPressed: () {
                      FirebaseService().logout();
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
                    },
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: AppColor.charcoalColor))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Logout",
                          style: TextStyle(
                              color: AppColor.charcoalColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height * 0.06,
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10), color: const Color(0xffEEEEEE)),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: clubIdController,
                        decoration: InputDecoration(hintText: "Club Id", border: InputBorder.none),
                      ),
                    ),

                    SizedBox(height: size.width * 0.04),

                    // match ID field
                    Container(
                      height: size.height * 0.06,
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10), color: const Color(0xffEEEEEE)),
                      child: TextField(
                        controller: matchIdController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(hintText: "Match Id", border: InputBorder.none),
                      ),
                    ),

                    SizedBox(height: size.width * 0.04),

                    // login button
                    SizedBox(
                      height: size.height * 0.06,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.charcoalColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        child: const Text(
                          "Stream",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
