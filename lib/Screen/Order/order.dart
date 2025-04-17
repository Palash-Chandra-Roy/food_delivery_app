import 'package:flutter/material.dart';
import 'package:food_delivery_app/Service/widget_support.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("Order", style: AppWidget.HeadlineTextFeildStyle()),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xFFececf8),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Color(0xffef2b39),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Jomuna market ",
                        style: AppWidget.simpleTextFeildStyle(),
                      ),
                    ],
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/buger.png",
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 40),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Text(
                              "Chease Buger ",
                              style: AppWidget.boldTextFeildStyle(),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(
                                  Icons.format_list_numbered,
                                  color: Color(0xffef2b39),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "4",
                                  style: AppWidget.boldTextFeildStyle(),
                                ),
                                SizedBox(width: 30),

                                Icon(
                                  Icons.monetization_on,
                                  color: Color(0xffef2b39),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "\$40",
                                  style: AppWidget.boldTextFeildStyle(),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Pending!",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xffef2b39),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
