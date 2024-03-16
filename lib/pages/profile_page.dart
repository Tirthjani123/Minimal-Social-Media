// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_basics/components/my_backbutton.dart';
import 'package:flutter_firebase_basics/database.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();
  String currentUserEmail = "";

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder(
        future: getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            Map<String, dynamic>? user = snapshot.data!.data();
            currentUserEmail = user!['email'];
            return Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0, left: 20),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Icon(
                          Icons.person,
                          size: 64,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    user['username'],
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(user['email']),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: StreamBuilder(
                    stream: firestoreDatabase.getPosts(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Container(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Sorry! Internet Issue'));
                      } else if (snapshot.data == null ||
                          snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('NO DATA'));
                      }
                      final posts = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          String message = post['PostMessage'];
                          String useremail = post['UserEmail'];
                          Timestamp timeStamp = post['Timestamp()'];
                          if(useremail == currentUserEmail){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: ListTile(
                                title: Text(
                                  message,
                                  style: GoogleFonts.ubuntu(),
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      useremail + " - ",
                                      style: GoogleFonts.ubuntu(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 10,
                                      ),
                                    ),
                                    Text(
                                      timeStamp.toDate().day.toString() + '/',
                                      style: GoogleFonts.ubuntu(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 10,
                                      ),
                                    ),
                                    Text(
                                      timeStamp.toDate().month.toString() + '/',
                                      style: GoogleFonts.ubuntu(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 10,
                                      ),
                                    ),
                                    Text(
                                      timeStamp.toDate().year.toString(),
                                      style: GoogleFonts.ubuntu(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                          }
                          return null;
                        },
                      );
                    },
                  )),
                ],
              ),
            );
          } else {
            return Text('NO Data');
          }
        },
      ),
    );
  }
}
