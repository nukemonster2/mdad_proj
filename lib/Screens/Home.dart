
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/DashboardPage.dart';
import 'package:flutter_auth/Screens/EmployeeList.dart';
import 'package:flutter_auth/Screens/ProfileScreen.dart';
import 'package:flutter_auth/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 95.0;
  int _currentIndex = 0;

  final List<Widget> _children = [
    EmployeeList(),
    DashboardPage(), //dashboard
    ProfileScreen(),//user
  ];

  @override
  void initState() {
    super.initState();
    _fabHeight = _initFabHeight;
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .80;
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(0.0),
        child:Stack(
          children: <Widget>[
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedIconTheme: IconThemeData(color: accentColour, opacity: 1),
              unselectedIconTheme:
              IconThemeData(opacity: 0.4), //opacity ranged from 0 to 1
              iconSize: 18,
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.user),
                  label: 'Employee List',
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.userFriends),
                  label: 'User',
                ),
              ],
              onTap: (itemIndex) {
                setState(() {
                  _currentIndex = itemIndex;
                });
              },
            ),
          ],
        ),
      ),
      extendBody: true,
      body: SafeArea(bottom: false, child: _children[_currentIndex]),
    );
  }

}
