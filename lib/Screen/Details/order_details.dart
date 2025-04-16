import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart'
    show SetupPaymentSheetParameters, Stripe, StripeException;
import 'package:food_delivery_app/Service/database.dart';
import 'package:food_delivery_app/Service/shared_pref.dart';
import 'package:food_delivery_app/Service/widget_support.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:random_string/random_string.dart';

class OrderDetails extends StatefulWidget {
  final String name;
  final String image;
  final String price;

  const OrderDetails({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
  }) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  Map<String, dynamic>? paymentIntent;
  String? name, id, email;
  int quantity = 1;
  int totalPrice = 0;

  getthesharedpref() async {
    name = await SharedpreferenceHelper().getUserName();
    id = await SharedpreferenceHelper().getUserId();
    email = await SharedpreferenceHelper().getUserEmail();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getthesharedpref();
    totalPrice = int.parse(widget.price.replaceAll('\$', ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
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
              Text(widget.name, style: AppWidget.HeadlineTextFeildStyle()),
              SizedBox(height: 10),
              Text(" " + widget.price, style: AppWidget.priceTextFeildStyle()),
              SizedBox(height: 30),
              Text(
                "We've established that most cheeses will melt when baked atop pizza. But which will not only melt but stretch into those gooey, messy strands that can make pizza eating such a delightfully challenging endeavor?",
                style: AppWidget.simpleTextFeildStyle(),
              ),
              SizedBox(height: 30),
              Text("Quantity", style: AppWidget.simpleTextFeildStyle()),
              SizedBox(height: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        quantity++;
                        totalPrice += int.parse(
                          widget.price.replaceAll('\$', ''),
                        );
                      });
                    },
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        padding: EdgeInsets.all(8),
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
                  SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {
                      if (quantity > 1) {
                        quantity = quantity - 1;

                        // $ সাইন বাদ দিয়ে parse করা হলো:
                        totalPrice =
                            totalPrice -
                            int.parse(widget.price.replaceAll('\$', ''));

                        setState(() {});
                      }
                    },
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xffef2b39),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 30,
                        ),
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
                          // "" + widget.price.toString(),
                          //+ totalPrice.toString(),
                          style: AppWidget.boldWhiteTextFeildStyle(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  GestureDetector(
                    onTap: () {
                      makePayment(totalPrice.toString());
                    },
                    child: Material(
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, "USD");
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: "clientSecret",
              style: ThemeMode.dark,
              merchantDisplayName: 'Foodie Delivery',
            ),
          )
          .then((value) {});
      displayPaymentSheet(amount);

      await Stripe.instance.presentPaymentSheet();
      print('Payment successful!');
    } catch (e, s) {
      print('Exception:$e $e');
    }
  }

  displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance
          .presentPaymentSheet()
          .then((value) async {
            String orderId = randomAlphaNumeric(10);
            Map<String, dynamic> userOrderMap = {
              "name": name,
              "Id": id,
              "Quantity": quantity.toString(),
              "Total": totalPrice.toString(),
              "Email": email,
              "userOederId": orderId,
              "FoodName": widget.name,
              "FoodImage": widget.image,
              "Status": "Pending ",
            };

            await DatebaseMethods().addUserOrderDetails(
              userOrderMap,
              id!,
              orderId,
            );
            await DatebaseMethods().addAdminDetails(userOrderMap, orderId);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(
                  "Order Pleaed Successfully",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            );

            showDialog(
              context: context,
              builder:
                  (_) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green),
                            Text("Payment Successfull"),
                          ],
                        ),
                      ],
                    ),
                  ),
            );
            paymentIntent = null;
          })
          .onError((error, stackTrace) {
            print("Error is : ---> $error, $stackTrace");
          });
    } on StripeException catch (e) {
      print("Error is : ---> $e");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(content: Text("Cancelled")),
      );
    } catch (e) {
      print(e);
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        "amount": calculateAmount(amount),
        "currency": currency,
        "payment_method_types[]": "card",
      };
      var response = await http.post(
        Uri.parse(
          "https://api.stripe.com/v1/payment_intents",
        ), // Use Stripe endpoint or your Firebase Function endpoint
        headers: {
          // Add to SecretKey value ;
          //Example: String secretkey = " your ke value";
          'Authorization':
              'Bearer sk_test_YOUR_SECRET_KEY ', // NEVER expose this in production
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: body,
      );
      return jsonDecode(response.body);
    } catch (err) {
      print("Error charging user: ${err.toString()}");
      return null;
    }
  }

  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount) * 100);
    return calculatedAmount.toString();
  }
}
