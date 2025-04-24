import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Service/database.dart';
import 'package:food_delivery_app/Service/shared_pref.dart';
import 'package:food_delivery_app/Service/widget_support.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String? id;

  getthesahredpref() async {
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  getOnTheLoad() async {
    await getthesahredpref();
    orderStream = await DatabaseMethods().getUserOrders(id!);
    setState(() {});
  }

  @override
  void initState() {
    getOnTheLoad();
    setState(() {});
  }

  Stream? orderStream;

  Widget allOrder() {
    return StreamBuilder(
      stream: orderStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height / 05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white,
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
                            ds["Address"],
                            style: AppWidget.simpleTextFeildStyle(),
                          ),
                        ],
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: Row(
                          children: [
                            Image.asset(
                              ds["FoodImage"],
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5),
                                Text(
                                  ds["FoodName"],
                                  style: AppWidget.boldTextFeildStyle(),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.format_list_numbered,
                                      color: Color(0xffef2b39),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      ds["Quantity"],
                                      style: AppWidget.boldTextFeildStyle(),
                                    ),
                                    SizedBox(width: 20),

                                    Icon(
                                      Icons.monetization_on,
                                      color: Color(0xffef2b39),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "\$" + ds["Total"],
                                      style: AppWidget.boldTextFeildStyle(),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  ds["Status"],
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
                );
              },
            )
            : Container();
      },
    );
  }

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
        child: allOrder(),
      ),
    );
  }
}
