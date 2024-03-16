// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper_function.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DrawerHeader(
                child: Icon(Icons.favorite),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/home_page');
                  },
                  leading: Icon(Icons.home),
                  title: Text('H O M E'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  onTap:(){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/profile_page');
                  },
                  leading: Icon(Icons.person),
                  title: Text('P R O F I L E'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/user_page');
                  },
                  leading: Icon(Icons.group),
                  title: Text('U S E R'),
                ),
              ),
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              onTap: (){
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/login_page');
              },
              leading: Icon(Icons.logout_outlined),
              title: Text('L O G O U T'),
            ),
          ),
        ],
      ),
    );
  }
}
