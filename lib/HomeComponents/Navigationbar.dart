import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomBNavigator extends StatelessWidget {
  var index = 0;

  BottomBNavigator({required this.OnTapping});
  int _page = 0;
  static GlobalKey<CurvedNavigationBarState> bottomNavigationKey =
      GlobalKey<CurvedNavigationBarState>();
  ValueChanged<int> OnTapping;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: bottomNavigationKey,
      index: 0,
      height: 60.0,
      items: const <Widget>[
        Icon(Icons.logout, size: 30),
        SizedBox(
          width: 30,
        ),
        Icon(Icons.home, size: 30),
        SizedBox(
          width: 30,
        ),
        Icon(Icons.perm_identity, size: 30),
      ],
      color: Colors.white,
      buttonBackgroundColor: Colors.white,
      backgroundColor: const Color.fromARGB(163, 12, 117, 99),
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 600),
      onTap: OnTapping,
      letIndexChange: (index) => true,
    );
  }
}
