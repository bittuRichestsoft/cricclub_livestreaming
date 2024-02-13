import 'package:cricclub_livestreaming/main.dart';
import 'package:cricclub_livestreaming/screens/auth/signup_page.dart';
import 'package:cricclub_livestreaming/screens/match_join_screen.dart';
import 'package:cricclub_livestreaming/services/firebase_service.dart';
import 'package:cricclub_livestreaming/utils/app_constants/app_color.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../utils/common_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isPasswordShow = false;
  bool isLoginStart = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.04),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.1),
                Center(
                  child: CircleAvatar(
                    radius: size.width * 0.15,
                    backgroundColor: AppColor.charcoalColor,
                  ),
                ),
                SizedBox(height: size.height * 0.05),

                // login view
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 33, fontWeight: FontWeight.w700),
                ),

                SizedBox(height: size.width * 0.04),

                // email field
                Container(
                  height: size.height * 0.06,
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: const Color(0xffEEEEEE)),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(hintText: "Email Id", border: InputBorder.none),
                  ),
                ),

                SizedBox(height: size.width * 0.04),

                // password field
                Container(
                  height: size.height * 0.06,
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: const Color(0xffEEEEEE)),
                  child: TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: isPasswordShow ? false : true,
                    decoration: InputDecoration(
                        hintText: "Password",
                        border: InputBorder.none,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            isPasswordShow = !isPasswordShow;
                            setState(() {});
                          },
                          child: Icon(isPasswordShow ? Icons.visibility : Icons.visibility_off),
                        )),
                  ),
                ),

                SizedBox(height: size.width * 0.04),

                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColor.charcoalColor,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: size.width * 0.08),

                // login button
                SizedBox(
                  height: size.height * 0.06,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (emailController.text.isEmpty) {
                        showSnackBar("Please enter your email");
                      } else if (!isEmailCheck(emailController.text)) {
                        showSnackBar("Please enter valid email");
                      } else if (passwordController.text.isEmpty) {
                        showSnackBar("Please enter your password");
                      } else {
                        isLoginStart = true;
                        setState(() {});
                        FirebaseService()
                            .login(emailController.text, passwordController.text)
                            .then((value) {
                          isLoginStart = false;

                          showSnackBar("Login Successfully");
                          prefs.setBool("isLogin", true);
                          setState(() {});
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => MatchJoinScreen()),
                              (route) => false);
                        }).onError((error, stackTrace) {
                          isLoginStart = false;
                          showSnackBar(error.toString());
                          setState(() {});
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.charcoalColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    child: isLoginStart
                        ? SizedBox(
                            width: size.width * 0.04,
                            height: size.width * 0.04,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                        : Text(
                            "Sign In",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                          ),
                  ),
                ),

                SizedBox(height: size.width * 0.08),

                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => SignupPage()));
                    },
                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColor.charcoalColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isEmailCheck(String email) {
    bool isValidEmail = EmailValidator.validate(email);
    return isValidEmail;
  }
}
