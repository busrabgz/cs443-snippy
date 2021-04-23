import 'package:flutter/material.dart';
import 'package:snippy_ui/services/auth.dart';

class DrawerComponent extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      DrawerHeader(
          decoration: BoxDecoration(color: Colors.purple[300]),
          child: Column(children: <Widget>[
            SizedBox(height: 10.0),
            Align(
                alignment: Alignment.center,
                child: CircleAvatar(backgroundColor: Colors.white)),
            SizedBox(height: 10.0),
            Align(
                alignment: Alignment.center,
                child: Text('Ozan Aydın',
                    style: TextStyle(color: Colors.white, fontSize: 14.0))),
            Align(
                alignment: Alignment.center,
                child: Text('ozanaydinn@gmail.com',
                    style: TextStyle(color: Colors.white70, fontSize: 14.0))),
          ])),
      ListTile(
        title: Text('Home',
            style: TextStyle(fontSize: 20.0, color: Colors.purple)),
        onTap: () {},
      ),
      ListTile(
        title: Text('Reports',
            style: TextStyle(fontSize: 20.0, color: Colors.purple)),
        onTap: () {},
      ),
      ListTile(
        title: Text('Settings',
            style: TextStyle(fontSize: 20.0, color: Colors.purple)),
        onTap: () {},
      ),
      ListTile(
        title: Text('Log out',
            style: TextStyle(fontSize: 20.0, color: Colors.purple)),
        onTap: () async {
          _auth.signOut();
          Navigator.popUntil(context, (route) => route.isFirst);
        },
      ),
    ]));
  }
}
