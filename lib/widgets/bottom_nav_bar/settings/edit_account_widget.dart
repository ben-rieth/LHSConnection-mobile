import 'package:flutter/material.dart';

import 'package:lhs_connections/app_state_container.dart';

class EditAccount extends StatefulWidget {
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  TextEditingController _nameController;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _nameChanged = false;
  bool _interestsChanged = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var container = AppStateContainer.of(context);

    final String initialName = container.state.userInformation.fName;

    _nameController =
        TextEditingController.fromValue(TextEditingValue(text: initialName));

    return WillPopScope(
      onWillPop: _checkIfChanged,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Update Account",
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
              TextField(
                controller: _nameController,
                onChanged: (String newName) {
                  if(newName != initialName) {
                    setState(() {
                      _nameChanged = true;
                    });
                  }
                },
              ),
              SizedBox(height: 20.0),
              FlatButton(
                color: Colors.green,
                onPressed: () {},
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
      ),
    );

  }

  void _checkIfChanged() {
    if(_nameChanged) {

    }
  }
}
