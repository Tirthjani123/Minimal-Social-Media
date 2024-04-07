// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_basics/components/my_button.dart';
import 'package:flutter_firebase_basics/components/my_texFeild.dart';
import 'package:flutter_firebase_basics/helper_function.dart';
import 'package:flutter_firebase_basics/pages/home.dart';
import 'package:flutter_firebase_basics/pages/sigin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void loginUser()async{
    if(!emailController.text.isEmpty && !passwordController.text.isEmpty){
      showDialog(context: context, builder: (context)=> Center(child: CircularProgressIndicator()));
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
      }on FirebaseAuthException catch(e){
        Navigator.pop(context);
        displayMessageToUser(e.code, context);
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'S O C I A L',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: MyTextField(
                  hintText: 'Email',
                  obscureText: false,
                  TextEditingController: emailController,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: MyTextField(
                  hintText: 'Password',
                  obscureText: true,
                  TextEditingController: passwordController,
                ),
              ),
              Row(
                children: [
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text(
                      'ForgotPassWord?',
                      style: TextStyle(fontWeight: FontWeight.w100),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: MyButton(
                  text: 'LOGIN',
                  onTap: loginUser,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?   ",
                      style: TextStyle(fontWeight: FontWeight.w100),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninPage()));
                      },
                      child: Text(
                        'Register Here',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
