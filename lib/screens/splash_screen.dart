import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.orange,
          Colors.deepOrange,
          Colors.deepOrange,
          Colors.orange,
        ],
      )),
     
      child: Scaffold(
        body: Center(
          child: Text('Loading...'),
        ),
      ),
    );
  }
}
