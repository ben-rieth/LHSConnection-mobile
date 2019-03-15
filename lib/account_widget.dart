import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    FocusScope.of(context).requestFocus(new FocusNode());

    return new Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          children: <Widget>[

            Center(
              child: CircleAvatar(
                child: Text("Picture"),
                radius: 50.0,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Center(
                child: Text(
                  "Name Goes Here",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
              ),
            ),



          ],
        ),
      ),
    );

  }
}