// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_basics/components/my_drawer.dart';
import 'package:flutter_firebase_basics/components/my_postbutton.dart';
import 'package:flutter_firebase_basics/components/my_texFeild.dart';
import 'package:flutter_firebase_basics/database.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController newPostController = TextEditingController();
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();

  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      String msg = newPostController.text;
      firestoreDatabase.addPost(msg);
    }
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Center(child: Padding(
          padding: const EdgeInsets.only(right: 64.0),
          child: Text("W A L L"),
        )),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: MyDrawer(),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: MyTextField(
                    hintText: 'Say Something...',
                    obscureText: false,
                    TextEditingController: newPostController,
                  )),
                  MyPostButton(onTap: postMessage),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: firestoreDatabase.getPosts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      // child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Sorry! Internet Issue');
                  } else if (snapshot.data == null ||
                      snapshot.data!.docs.isEmpty) {
                    return Text('NO DATA');
                  }
                  final posts = snapshot.data!.docs;
                  return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary
                    ),
                    child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        String message = post['PostMessage'];
                        String useremail = post['UserEmail'];
                        Timestamp timeStamp = post['Timestamp()'];
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
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
                      },
                    ),
                  );
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}
