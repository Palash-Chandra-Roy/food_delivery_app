import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery_app/Service/database.dart';
import 'package:food_delivery_app/Service/key.dart';
import 'package:food_delivery_app/Service/shared_pref.dart';
import 'package:food_delivery_app/Service/widget_support.dart';
import 'package:http/http.dart' as http;

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  TextEditingController amountController = new TextEditingController();
  Map<String, dynamic>? paymentIntent;
  String? email, wallet, id;

  getthesharedpref() async {
    email = await SharedPreferenceHelper().getUserEmail();
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  getUserWallet() async {
    await getthesharedpref();
    QuerySnapshot querySnapshot = await DatabaseMethods().getUserWalletbyemail(
      email!,
    );

    wallet = "${querySnapshot.docs[0]["Wallet"]}";
    print(wallet);
    setState(() {});
  }

  @override
  void initState() {
    getUserWallet();
    super.initState();
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
      body:
          wallet == null
              ? Center(child: CircularProgressIndicator())
              : Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,

                decoration: const BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/wallet.png",
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 50),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Your Wallet",
                                    style: AppWidget.boldTextFeildStyle(),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "\$" + wallet!,
                                    style: AppWidget.boldTextFeildStyle(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  makePayment("100");
                                },
                                child: Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),

                                    color: Colors.white,
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "\$100",
                                      style: AppWidget.priceTextFeildStyle(),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  makePayment("80");
                                },
                                child: Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "\$80",
                                      style: AppWidget.priceTextFeildStyle(),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  makePayment("200");
                                },
                                child: Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "\$200",
                                      style: AppWidget.priceTextFeildStyle(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            OpenBox();
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xffef2b39),
                            ),
                            child: Center(
                              child: Text(
                                "Add Money",
                                style: AppWidget.boldWhiteTextFeildStyle(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, "USD");
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent?["client_secret"],
              // paymentIntentClientSecret: "clientSecret",
              style: ThemeMode.dark,
              merchantDisplayName: 'Palash',
            ),
          )
          .then((value) {});
      displayPaymentSheet(amount);
      //await Stripe.instance.presentPaymentSheet();
      print('Payment successful!');
    } catch (e, s) {
      print('Exception:$e $s');
    }
  }

  displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance
          .presentPaymentSheet()
          .then((value) async {
            int updatewallet = int.parse(wallet!) + int.parse(amount);
            await DatabaseMethods().updateUserWallet(
              updatewallet.toString(),
              id!,
            );
            await getUserWallet();
            setState(() {});

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
              'Bearer sk_test_YOUR_SECRET_KEY $secretkey', // NEVER expose this in production
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

  Future OpenBox() => showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          content: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.cancel),
                      ),
                      SizedBox(width: 30),
                      Text(
                        " Add Amount ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff008080),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("Enter your Amount"),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: amountController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Amount",
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        makePayment(amountController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(
                          0xff008080,
                        ), // Change to any color you like
                      ),
                      child: Text(
                        "Add ",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
  );
}
