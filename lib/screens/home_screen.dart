import 'package:ecommerce/screens/user_info.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/custom_bottom_bar.dart';
import 'all_categories.dart';
import 'all_products.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isNight = false;
  final _inactiveColor = Colors.grey[700];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'E-Commerce',
          style: TextStyle(color: Colors.orange),
        ),
        centerTitle: true,
      ),
      body: getBody(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      const AllProductsScreen(),
      const AllCategoriesScreen(),
      const CartScreen(),
      const UserInfoScreen(),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }

  Widget _buildBottomBar() {
    Color activeColor = Colors.orange;

    return CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: const Icon(Icons.home),
          title: const Text(
            'Home',
            style: kMediumTextStyle,
          ),
          activeColor: activeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.list_alt),
          title: const Text(
            'Categories',
            style: kMediumTextStyle,
          ),
          activeColor: activeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.shopping_cart),
          title: const Text(
            'Cart',
            style: kMediumTextStyle,
          ),
          activeColor: activeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.settings),
          title: const Text(
            'Settings',
            style: kMediumTextStyle,
          ),
          activeColor: activeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
