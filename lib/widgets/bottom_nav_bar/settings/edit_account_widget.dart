import 'package:flutter/material.dart';

import 'package:lhs_connections/app_state_container.dart';

class EditAccount extends StatefulWidget{
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {

  TextEditingController _nameController;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isChange = false;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var container = AppStateContainer.of(context);

    final initialName = container.state.userInformation.fName;
    String currentName = initialName;

    _nameController = TextEditingController
        .fromValue(TextEditingValue(text: initialName));


    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Account",
          style: TextStyle(
            color: Colors.green,
          )),
        backgroundColor: Colors.grey[350],
      ),

      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(24.0),
          children: <Widget>[

            Center(
              child: CircleAvatar(
                child: Text("Picture"),
                radius: 50.0,
              ),
            ),

            SizedBox(height: 20.0),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "FIRST NAME",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16.0,
                ),
              ),
            ),

            TextFormField(
              controller: _nameController,
            ),

            SizedBox(height: 20.0),

            FlatButton(
              color: Colors.green,
              onPressed: () {

              },

              child: Text("Edit Interests"),
            ),

            /*RaisedButton(
              color: !isChange ? Colors.green : Colors.transparent,
              onPressed: () {

              },

              child: Text(
                "UPDATE ACCOUNT",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),*/

          ],

        ),
      ),
    );
  }
}