import 'package:flutter/material.dart';

class SurveySelectScreen extends StatefulWidget {
  State<SurveySelectScreen> createState() => _SurveySelectScreenState();
}

class _SurveySelectScreenState extends State<SurveySelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {

        },
        itemCount: 10,
      ),
    );
  }
}