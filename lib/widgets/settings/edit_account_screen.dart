import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lhs_connections/widgets/settings/interest_select/interest_select_screen.dart';

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

    _nameController = TextEditingController();

    return WillPopScope(
      onWillPop: () {},
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
              /*TextField(
                controller: _nameController,
                onChanged: (String newName) {
                  if(newName != initialName) {
                    setState(() {
                      _nameChanged = true;
                    });
                  }
                },
              ),*/
              SizedBox(height: 20.0),
              FlatButton(
                color: Colors.green,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              InterestSelectScreen()
                      ));
                },
                child: Text("Edit Interests"),
              ),

              _nameChanged ? Text("Change!") : Container(),

            ],
          ),
        ),
      ),
    );

  }

  /*Future<bool> _checkIfChanged() async {

    var container = AppStateContainer.of(context);

    if(_nameChanged) {
      final DocumentReference userRef = Firestore.instance.collection('students')
          .document(container.state.userInformation.id);

      Firestore.instance.runTransaction((Transaction tx) async {
        DocumentSnapshot userSnapshot = await tx.get(userRef);
        if(userSnapshot.exists) {
          await tx.update(userRef, <String, dynamic>{'fName': _nameController.text} );
        }
      });
    }

    return true;

  }*/
}