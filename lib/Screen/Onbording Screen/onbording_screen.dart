import 'package:flutter/material.dart';
import 'package:food_delivery_app/Service/widget_support.dart';

class OnbordingScreen extends StatefulWidget {
  const OnbordingScreen({super.key});

  @override
  State<OnbordingScreen> createState() => _OnbordingScreenState();
}

class _OnbordingScreenState extends State<OnbordingScreen> {
  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Center(child: Image.asset("assets/images/onbording.png")),
            SizedBox(height: 20),
            Text(
              "This Fested \n Food Delivery ",
              textAlign: TextAlign.center,
              style: AppWidget.HeadlineTextFeildStyle(),
            ),
            SizedBox(height: 20),
            Text(
              "Craving something delicious? \n Order now and get your favorites\n deleverd fast! ",
              textAlign: TextAlign.center,
              style: AppWidget.simpleTextFeildStyle(),
            ),
            SizedBox(height: 30),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                color: Color(0xff8c592a),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  " Get Started",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
