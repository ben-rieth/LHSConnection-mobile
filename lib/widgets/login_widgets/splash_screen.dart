import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 100.0,
              child: Image.asset('assets/lhsConnections.png',),
            ),

            SizedBox(height: 30.0),

            CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
            ),

         ],
        )
      ),
    );
  }
}
