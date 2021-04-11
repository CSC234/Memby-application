import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:memby/screens/landingScreen.dart';
import 'package:memby/screens/profileSreen.dart';
import 'package:memby/screens/addProductScreen.dart';

class NavKT extends StatefulWidget {
  final int currentIndex;
  @override
  const NavKT({Key key, this.currentIndex}) : super(key: key);
  _State createState() => _State();
}

class _State extends State<NavKT> {
  @override
  int _currentIndex = 2;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavyBar(
        selectedIndex: widget.currentIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          print(index);
          if (index == 0 && widget.currentIndex != 0)
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Landing();
                },
              ),
            );
          if (index == 2 && widget.currentIndex != 2)
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AddProductList();
                },
              ),
            );
          if (index == 4 && widget.currentIndex != 4)
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Profile();
                },
              ),
            );

          _currentIndex = index;
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 300), curve: Curves.ease);
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Home'),
            activeColor: Color(0xFF4941BB),
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('Create Order'),
              activeColor: Color(0xFF4941BB)),
          BottomNavyBarItem(
              icon: Icon(Icons.add_shopping_cart),
              title: Text('Add product'),
              activeColor: Color(0xFF4941BB)),
          BottomNavyBarItem(
              icon: Icon(Icons.dashboard_rounded),
              title: Text('Dashboard'),
              activeColor: Color(0xFF4941BB)),
          BottomNavyBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
              activeColor: Color(0xFF4941BB)),
        ],
      ),
    );
  }
}
