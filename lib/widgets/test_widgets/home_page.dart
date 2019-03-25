import 'package:flutter/material.dart';

import 'package:lhs_connections/redux_utils/containers/counter/counter.dart';
import 'package:lhs_connections/redux_utils/containers/counter/increase_counter.dart';

class HomePage extends StatelessWidget {
  final String title;

  HomePage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                'YOu have pushed the button this many times:'
              ),

              new Counter(),
            ],
          ),
        ),
      ),
      floatingActionButton: new IncreaseCountButton(),
    );
  }
}