import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screen/BotomNavBar/bottom_nav_bar.dart';
import 'package:food_delivery_app/Screen/Log%20In/login.dart';
import 'package:food_delivery_app/Service/database.dart';
import 'package:food_delivery_app/Service/shared_pref.dart';
import 'package:food_delivery_app/Service/widget_support.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';

class Singup extends StatefulWidget {
  const Singup({super.key});

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  String email = "", password = "", name = "";
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  // final AuthController authController = Get.find<AuthController>();
  void registration() async {
    if (password.isNotEmpty &&
        nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        String Id = randomAlphaNumeric(10);

        Map<String, dynamic> userInfoMap = {
          " Name": nameController.text,
          "Email": emailController.text,

          " Id": Id,
        };
        await SharedPreferenceHelper().saveUserEmail(email);
        await SharedPreferenceHelper().saveUserName(name);
        await SharedPreferenceHelper().saveUserId(Id);

        await DatebaseMethods().addUserDetails(userInfoMap, Id);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Registered Successfully",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        );
        Get.to(BottomNavBar());
      } on FirebaseException catch (e) {
        if (e.code == "weak-password") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password Provided is too weak",
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        } else {
          if (e.code == "email-already-in-use") {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.orangeAccent,
                content: Text(
                  "Account Already exists",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.orangeAccent,
                content: Text(
                  "SignUp failed: ${e.message}",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            );
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 30),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(
              color: Color(0xffffefbf),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/pan.png",
                  height: 200,
                  width: 250,
                  fit: BoxFit.fill,
                ),
                Image.asset(
                  "assets/images/logo.png",
                  height: 50,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 3.2,
              left: 20,
              right: 20,
            ),
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: EdgeInsets.only(right: 20, left: 20, top: 20),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.66,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "SignUp ",
                          style: AppWidget.HeadlineTextFeildStyle(),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text("Name", style: AppWidget.signUpTextFeildStyle()),
                      SizedBox(height: 5.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFececf8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter name",
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      Text("Email", style: AppWidget.signUpTextFeildStyle()),
                      SizedBox(height: 5.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFececf8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      Text("Password", style: AppWidget.signUpTextFeildStyle()),
                      SizedBox(height: 5.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFececf8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Passwoed",
                            prefixIcon: Icon(Icons.password),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Center(
                        child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xffef2b39),
                          ),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                if (nameController.text.isNotEmpty &&
                                    emailController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty) {
                                  setState(() {
                                    name = nameController.text;
                                    email = emailController.text;
                                    password = passwordController.text;
                                  });

                                  registration();
                                }
                              },
                              child: Text(
                                "Sign Up",
                                style: AppWidget.whiteTextFeildStyle(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an Account?",
                            style: AppWidget.simpleTextFeildStyle(),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              Get.to(Login());
                            },
                            child: Text(
                              "LogIn",
                              style: AppWidget.boldTextFeildStyle(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
