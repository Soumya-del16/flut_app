import 'package:flut_app/allscreens/home_fragments/home_address_frag.dart';
import 'package:flut_app/allscreens/home_fragments/home_page_frag.dart';
import 'package:flut_app/allscreens/home_fragments/my_profile_frag.dart';
import 'package:flut_app/allscreens/home_fragments/notification_frag.dart';
import 'package:flut_app/allscreens/seperate_classes/clip_board_copy_paste.dart';
import 'package:flut_app/allscreens/seperate_classes/my_profile_select_image.dart';
import 'file:///D:/flutterapps/flut_app/lib/allscreens/home_fragments/my_account_frag.dart';
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
   //MyProfileWidget(),
   // MyNewSelectImage(),
    //HomeCopyPage(),
    AddressListViewHandelItem(),
    MyNotificationRecyclerClass(),
    MyAcountScreen(),
  ];//

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

