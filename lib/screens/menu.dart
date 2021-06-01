import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Vinu Balagopal A P"),
              accountEmail: Text("vinubalagopalap@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.blue
                        : Colors.white,
                child: Text(
                  "VB",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Previous Links'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
