// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_basics/components/my_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/my_backbutton.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Has Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData) {
            return Text('No Data');
          } else {
            final users = snapshot.data!.docs;
            return Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:50.0,left: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: MyBackButton(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Center(child: Text('U S E R S',style: GoogleFonts.ubuntu(fontSize: 30),)),
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    padding: EdgeInsets.all(0),
                    itemBuilder: (context,index) {
                      final user = users[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).colorScheme.primary
                          ),
                          child: ListTile(
                            title: Text(user['username']),
                            subtitle: Text(user['email']),
                          ),
                        ),
                      );
                    }
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
