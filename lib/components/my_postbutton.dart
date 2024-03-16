import 'package:flutter/material.dart';

class MyPostButton extends StatelessWidget {
  final Function()? onTap;
  const MyPostButton({super.key,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primary,
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(left:5,right: 10),
        child: Center(
          child: Icon(Icons.done,color: Theme.of(context).colorScheme.inversePrimary,),
        ),
      ),
    );
  }
}
