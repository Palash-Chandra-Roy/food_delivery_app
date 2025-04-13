import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screen/Home%20Screen/home_screen.dart';
import 'package:food_delivery_app/Screen/Order/order.dart';
import 'package:food_delivery_app/Screen/Profile/profile.dart';
import 'package:food_delivery_app/Screen/Wallet/wallet.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late List<Widget> pages;

  late HomeScreen homeScreen;
  late Order order;
  late Wallet wallet;
  late Profile profile;

  int cureentIndex = 0;

  @override
  void initState() {
    homeScreen = HomeScreen();
    order = Order();
    wallet = Wallet();
    profile = Profile();

    pages = [homeScreen, order, wallet, profile];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.black,
        height: 70,
        animationDuration: Duration(microseconds: 500),
        onTap: (int index) {
          setState(() {
            cureentIndex = index;
          });
        },
        items: [
          Icon(Icons.home, color: Colors.white, size: 30),
          Icon(Icons.shopping_bag, color: Colors.white, size: 30),
          Icon(Icons.wallet, color: Colors.white, size: 30),
          Icon(Icons.person, color: Colors.white, size: 30),
        ],
      ),
      body: pages[cureentIndex],
    );
  }
}
