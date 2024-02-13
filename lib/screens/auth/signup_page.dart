import 'package:cricclub_livestreaming/main.dart';
import 'package:cricclub_livestreaming/services/firebase_service.dart';
import 'package:cricclub_livestreaming/utils/app_constants/app_color.dart';
import 'package:cricclub_livestreaming/utils/common_widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../match_join_screen.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  bool isCheck = false;
  bool isPasswordShow = false;
  bool isConfirmPasswordShow = false;
  bool isSignUpStart = false;

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
                  "Signup",
                  style: TextStyle(fontSize: 33, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: size.width * 0.04),

                // name field
                Container(
                  height: size.height * 0.06,
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: const Color(0xffEEEEEE)),
                  child: TextField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(hintText: "Name", border: InputBorder.none),
                  ),
                ),

                SizedBox(height: size.width * 0.04),

                // email field
                Container(
                  height: size.height * 0.06,
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: const Color(0xffEEEEEE)),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
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
                      ),
                    ),
                  ),
                ),

                SizedBox(height: size.width * 0.04),

                // confirm password field
                Container(
                  height: size.height * 0.06,
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: const Color(0xffEEEEEE)),
                  child: TextField(
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.text,
                    obscureText: isConfirmPasswordShow ? false : true,
                    decoration: InputDecoration(
                        hintText: "Confirm Password",
                        border: InputBorder.none,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            isConfirmPasswordShow = !isConfirmPasswordShow;
                            setState(() {});
                          },
                          child: Icon(isPasswordShow ? Icons.visibility : Icons.visibility_off),
                        )),
                  ),
                ),

                SizedBox(height: size.width * 0.04),

                Row(
                  children: [
                    SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: isCheck,
                          activeColor: AppColor.charcoalColor,
                          onChanged: (value) {
                            isCheck = value!;
                            setState(() {});
                          },
                        )),
                    SizedBox(width: size.width * 0.04),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                // fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: AppColor.charcoalColor),
                            children: [
                              TextSpan(text: "I accept the "),
                              TextSpan(
                                  text: "Terms of use",
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: " and "),
                              TextSpan(
                                  text: "Privacy policy.",
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                            ]),
                      ),
                    )
                  ],
                ),

                SizedBox(height: size.width * 0.08),

                // login button
                SizedBox(
                  height: size.height * 0.06,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isEmpty) {
                        showSnackBar("Please enter your name");
                      } else if (emailController.text.isEmpty) {
                        showSnackBar("Please enter your email");
                      } else if (!isEmailCheck(emailController.text)) {
                        showSnackBar("Please enter valid email");
                      } else if (passwordController.text.isEmpty) {
                        showSnackBar("Please enter your password");
                      } else if (passwordController.text.length < 8) {
                        showSnackBar("Password must be 8 character or long");
                      } else if (passwordController.text != confirmPasswordController.text) {
                        showSnackBar("Confirm password is not matched");
                      } else if (!isCheck) {
                        showSnackBar("Please accept the terms and conditions before proceed");
                      } else {
                        isSignUpStart = true;
                        setState(() {});
                        FirebaseService()
                            .signUp(
                                nameController.text, emailController.text, passwordController.text)
                            .then((value) {
                          showSnackBar("Account Created Successfully");
                          isSignUpStart = false;
                          setState(() {});

                          prefs.setBool("isLogin", true);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => MatchJoinScreen()),
                              (route) => false);
                        }).onError((error, stackTrace) {
                          isSignUpStart = false;
                          setState(() {});
                          showSnackBar(error.toString());
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.charcoalColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    child: isSignUpStart
                        ? SizedBox(
                            width: size.width * 0.04,
                            height: size.width * 0.04,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                        : Text(
                            "Sign Up",
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
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Login to your Account",
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
