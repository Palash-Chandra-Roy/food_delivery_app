import 'package:flutter/material.dart';
import 'package:food_delivery_app/Model/burger_model.dart';
import 'package:food_delivery_app/Model/category_model.dart';
import 'package:food_delivery_app/Model/chiken_model.dart';
import 'package:food_delivery_app/Model/pizza_model.dart';
import 'package:food_delivery_app/Model/shaorma_model.dart';
import 'package:food_delivery_app/Screen/Details/order_details.dart';
import 'package:food_delivery_app/Service/burger_data.dart';
import 'package:food_delivery_app/Service/category_data.dart';
import 'package:food_delivery_app/Service/chiken_data.dart';
import 'package:food_delivery_app/Service/pizza_data.dart';
import 'package:food_delivery_app/Service/shaorma_data.dart';
import 'package:food_delivery_app/Service/widget_support.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> categories = [];
  List<PizzaModel> pizza = [];
  List<BurgerModel> burger = [];
  List<ChikenModel> chiken = [];
  List<ShaormaModel> shaorma = [];

  int track = 0;
  @override
  void initState() {
    categories = getCategories();
    pizza = getPizza();
    burger = getBurger();
    chiken = getChiken();
    shaorma = getShaorma();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 40, left: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      height: 50,
                      width: 120,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      "Order your favourite food !",
                      style: AppWidget.simpleTextFeildStyle(),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/images/palash.png",
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFFececf8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: " Search food item.",
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xffef2b30),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.search, color: Colors.white, size: 30),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryTile(
                    categories[index].name!,
                    categories[index].image!,
                    index,
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            track == 0
                ? Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.66,
                        crossAxisSpacing: 15,
                      ),
                      itemCount: pizza.length,
                      itemBuilder: (context, index) {
                        return FoodTitle(
                          pizza[index].name!,
                          pizza[index].image!,
                          pizza[index].price!,
                        );
                      },
                    ),
                  ),
                )
                : track == 1
                ? Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.66,
                        crossAxisSpacing: 15,
                      ),
                      itemCount: burger.length,
                      itemBuilder: (context, index) {
                        return FoodTitle(
                          burger[index].name!,
                          burger[index].image!,
                          burger[index].price!,
                        );
                      },
                    ),
                  ),
                )
                : track == 2
                ? Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.66,
                        crossAxisSpacing: 15,
                      ),
                      itemCount: chiken.length,
                      itemBuilder: (context, index) {
                        return FoodTitle(
                          chiken[index].name!,
                          chiken[index].image!,
                          chiken[index].price!,
                        );
                      },
                    ),
                  ),
                )
                : track == 3
                ? Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.66,
                        crossAxisSpacing: 15,
                      ),
                      itemCount: shaorma.length,
                      itemBuilder: (context, index) {
                        return FoodTitle(
                          shaorma[index].name!,
                          shaorma[index].image!,
                          shaorma[index].price!,
                        );
                      },
                    ),
                  ),
                )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget FoodTitle(String name, String image, String price) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 10),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.black38),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              image,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),

          Text(name, style: AppWidget.boldTextFeildStyle()),
          Text(price, style: AppWidget.priceTextFeildStyle()),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(OrderDetails(name: name, image: image, price: price));
                },
                child: Container(
                  height: 50,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Color(0xffef2b30),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget CategoryTile(String name, String image, int categoryIndex) {
    return GestureDetector(
      onTap: () {
        track = categoryIndex;
        setState(() {});
      },
      child:
          track == categoryIndex
              ? Container(
                margin: EdgeInsets.only(right: 20, bottom: 10),
                child: Material(
                  borderRadius: BorderRadius.circular(30),
                  elevation: 3,
                  child: Container(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    decoration: BoxDecoration(
                      color: Color(0xffef2b39),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          image,
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 10),
                        Text(name, style: AppWidget.whiteTextFeildStyle()),
                      ],
                    ),
                  ),
                ),
              )
              : Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                margin: EdgeInsets.only(right: 20, bottom: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      image,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 10),
                    Text(name, style: AppWidget.simpleTextFeildStyle()),
                  ],
                ),
              ),
    );
  }
}
