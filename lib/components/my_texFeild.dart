import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final obscureText;
  final TextEditingController;
  MyTextField({super.key, required this.hintText, this.obscureText, this.TextEditingController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: TextEditingController,
        obscureText: obscureText,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          focusColor: Colors.black,
          labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),
          hoverColor: Colors.black,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
