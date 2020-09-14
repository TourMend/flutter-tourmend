import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter_app/screens/homePage.dart';
import '../../screens/homePage.dart';
import '../../screens/placesPage.dart';
import '../../screens/eventsPage.dart';
import '../../screens/newsPage.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30);
  final List<Widget> _widgetOption = <Widget>[
    HomePage(
      title: 'TourMend Home Page',
    ),
    PlacesPage(
      title: 'Places',
    ),
    EventsPage(),
    NewsPage(),
    Text(
      'Index 5: Saved',
      style: optionStyle,
    ),
  ];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        body: Center(child: _widgetOption.elementAt(_selectedIndex)),
        bottomNavigationBar: FFNavigationBar(
          theme: FFNavigationBarTheme(
            barBackgroundColor: Colors.white70,
            selectedItemBorderColor: Colors.yellow[300],
            selectedItemBackgroundColor: Colors.blue,
            selectedItemIconColor: Colors.white,
            selectedItemLabelColor: Colors.black,
          ),
          onSelectTab: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedIndex: _selectedIndex,
          items: [
            FFNavigationBarItem(
              iconData: Icons.home,
              label: 'Home',
            ),
            FFNavigationBarItem(
              iconData: Icons.place,
              label: 'Places',
            ),
            FFNavigationBarItem(
              iconData: Icons.event,
              label: 'Events',
            ),
            FFNavigationBarItem(
              iconData: Icons.assignment,
              label: 'News',
            ),
            FFNavigationBarItem(
              iconData: Icons.photo_library,
              label: 'Gallery',
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            actionsPadding: EdgeInsets.all(5.0),
            buttonPadding: EdgeInsets.all(20.0),
            title: Text('Are you sure?'),
            content: Text('Do you want to exit TourMend'),
            actions: <Widget>[
              GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text(
                  "NO",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text(
                  "YES",
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}
