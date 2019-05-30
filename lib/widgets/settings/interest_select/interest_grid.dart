import 'package:flutter/material.dart';

import 'package:lhs_connections/models/interest.dart';
import 'package:lhs_connections/widgets/custom_widgets/switch_icon_button.dart';

class InterestGrid extends StatelessWidget {

  final List<Interest> interestList;

  InterestGrid({@required this.interestList, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<SwitchIconButton> gridChildren = [];

    interestList.forEach((interest) {
      gridChildren.add(
          SwitchIconButton(
              activated: interest.selectedByCurrentUser,
              icon: interest.icon,
              title: interest.name,
              activatedColor: Theme.of(context).primaryColor,
              color: Colors.grey[600]));
    });

    return SliverGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 3.0,
      children: gridChildren,
    );
  }
}