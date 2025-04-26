import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Service/database.dart';
import 'package:food_delivery_app/Service/widget_support.dart';

class AllOrder extends StatefulWidget {
  const AllOrder({super.key});

  @override
  State<AllOrder> createState() => _AllOrderState();
}

class _AllOrderState extends State<AllOrder> {
  Stream? orderStream;

  getOnTheLoad() async {
    orderStream = await DatabaseMethods().getAdminOrders();
  }

  @override
  void initState() {
    super.initState();
    getOnTheLoad();
  }

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
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                            SizedBox(width: 20),
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
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: Color(0xffef2b39),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      ds["Name"],
                                      style: AppWidget.simpleTextFeildStyle(),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Icons.mail, color: Color(0xffef2b39)),
                                    SizedBox(width: 10),
                                    Text(
                                      ds["Email"],
                                      style: AppWidget.simpleTextFeildStyle(),
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

                                SizedBox(height: 5),
                                GestureDetector(
                                  onTap: () async {
                                    await DatabaseMethods().updateAdminOrders(
                                      ds.id,
                                    );
                                    await DatabaseMethods().updateUserOrders(
                                      ds["Id"],
                                      ds.id,
                                    );
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Delivered",
                                        style: AppWidget.whiteTextFeildStyle(),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
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
      body: Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xffef2b39),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 6),
                  Text("All Order", style: AppWidget.HeadlineTextFeildStyle()),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
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
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: allOrder(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
