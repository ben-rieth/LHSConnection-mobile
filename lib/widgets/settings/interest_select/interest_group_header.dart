import 'package:flutter/material.dart';

import 'package:lhs_connections/widgets/custom_widgets/sliver_header_delegate.dart';

class InterestGroupHeader extends StatelessWidget {

  final String headerText;

  InterestGroupHeader({@required this.headerText});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: SliverHeaderDelegate(
          minHeight: 60.0,
          maxHeight: 60.0,
          child: Container(
            margin: EdgeInsets.only(bottom: 5.0),
            color: Colors.green[800],
            child: Center(
              child: Text(
                headerText.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
      ),
    );
  }
}