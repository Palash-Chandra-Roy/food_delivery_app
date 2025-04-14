import 'package:flutter/material.dart';
import 'package:food_delivery_app/Service/widget_support.dart';
import 'package:get/get.dart';

class OrderDetails extends StatefulWidget {
  String name;
  String image;
  String price;
  OrderDetails({required this.name, required this.image, required this.price});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int quantity = 1;
  int totalPrice = 0;
  @override
  void initState() {
    totalPrice = int.parse(widget.price);
    //print("This is totalPrices$totalPrice");
    super.initState();
  }

  // void increaseQuantity() {
  //   quantity += 1;
  //   totalPrice = quantity * int.parse(widget.price ?? "");
  //   print(totalPrice);
  //   setState(() {});
  // }

  // void decreaseQuantity() {
  //   if (quantity > 1) {
  //     setState(() {
  //       quantity -= 1;
  //       totalPrice = quantity * int.parse(widget.price!);
  //       print(totalPrice);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xffef2b39),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            Center(
              child: Image.asset(
                widget.image,
                height: MediaQuery.of(context).size.height / 3,
                fit: BoxFit.contain,
              ),
            ),
            Text(widget.name ?? "", style: AppWidget.HeadlineTextFeildStyle()),
            SizedBox(height: 10),
            Text(widget.price, style: AppWidget.priceTextFeildStyle()),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: Text(
                "We've established that most cheeses will meit when baced atop pizza. but whicyh will not only melt but stretch into those gooey, messy strands that can make pizza eating such a dellghtfuly chanllengingendeavor? ",
                style: AppWidget.whiteTextFeildStyle(),
              ),
            ),
            SizedBox(height: 30),
            Text("Quantity", style: AppWidget.simpleTextFeildStyle()),
            SizedBox(height: 30),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    quantity = quantity + 1;
                    totalPrice = totalPrice + int.parse(widget.price);
                    setState(() {});
                  },
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffef2b39),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 30),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Text(
                  quantity.toString(),
                  style: AppWidget.HeadlineTextFeildStyle(),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    quantity = quantity - 1;
                    totalPrice = totalPrice - int.parse(widget.price);
                    setState(() {});
                  },
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffef2b39),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.remove, color: Colors.white, size: 30),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 60,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Color(0xffef2b39),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "\$" + totalPrice.toString(),
                        style: AppWidget.boldWhiteTextFeildStyle(),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 30),
                Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 70,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "ORDER NOW",
                        style: AppWidget.boldWhiteTextFeildStyle(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
