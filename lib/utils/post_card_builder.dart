import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

import 'package:lhs_connections/models/Post.dart';

class PostCardBuilder {

  Card buildPostCard(Post post)  {

    return Card(
      clipBehavior: Clip.antiAlias,
      child: ExpandableNotifier(
        child: Column(
          children: <Widget>[

            post.image != null ? makeImageBox(post.image.path) : Container(),

            makeContentCard(post.title, post.text),

          ],
        ),
      ),
    );
  }

  SizedBox makeImageBox(String imagePath) {
    return SizedBox(
      height: 150.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.rectangle,
        ),
        child: Image.asset(
          imagePath,
        ),
      ),
    );
  }

  ExpandablePanel makeContentCard(String title, String content) {
    return  ExpandablePanel(
        tapHeaderToExpand: true,

        header: Padding(
            padding: EdgeInsets.only(top: 10.0, left: 10.0),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            )
        ),

        collapsed: Text(content, softWrap: false, overflow: TextOverflow.ellipsis),
        expanded: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            Text(content, softWrap: true, overflow: TextOverflow.fade),

          ],
        ),

        builder: (_, collapsed, expanded) {
          return Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
            child: Expandable(
              collapsed: collapsed,
              expanded: expanded,
            ),
          );
        }

    );
  }

}