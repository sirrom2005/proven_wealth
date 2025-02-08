import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Common/MyColors.dart';

bool _admin =false;

class MyAppBar
{
  getAppBar(String title, BuildContext context, GlobalKey<ScaffoldState>? _scaffoldKey, {bool admin = false}){
    _admin = admin;
    return
      AppBar(
        elevation:0,
        backgroundColor:admin ? Colors.white : Colors.black,
        foregroundColor:admin ? Colors.black : Colors.white,
        title:title.isEmpty ? Image.asset(admin ? 'lib/assets/images/logo-for-white.png' : 'lib/assets/images/logo.png', width: 120) : Text(title??''),
        centerTitle: false,
        actions: [
          if(admin)
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                _scaffoldKey?.currentState?.openEndDrawer(); // Manually open the drawer
              },
            )
        ],
      );
  }
  
  getDrawer(){
    return
      Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: MyColors.appAccentColor,
              ),
              child: Text(
                _admin ? 'Manage Account' : 'Support',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('About Us'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Privacy Policy'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Help'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Disclaimer'),
            ),
          ],
        ),
      );
  }
}
