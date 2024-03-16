import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

displayMessageToUser(String msg, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(msg),
    ),
  );
}
void logout() {
  FirebaseAuth.instance.signOut();
}
