import 'package:flut_app/allscreens/home_fragments/notification_frag.dart';
import 'package:flutter/material.dart';


/// This Widget is the main application widget.


class MyNavigationBar extends StatefulWidget {
  //MyNavigationBar ({required Key key}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar > {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Text('Home Page', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
    MyNotificationRecyclerClass(),
  Text('Profile Page', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
  ];
  /*  Text('Home Page', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
    Text('Notifications Page', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
    Text('Profile Page', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),*/



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Home'),
         // backgroundColor: Colors.orange
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
                backgroundColor: Colors.orange
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                title: Text('Notifications'),
                backgroundColor: Colors.orange

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('My Account'),
              backgroundColor: Colors.orange,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 30,
          onTap: _onItemTapped,
          elevation: 3
      ),
    );
  }
}