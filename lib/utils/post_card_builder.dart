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

            post.text == null ? makeNoContentCard() : makeContentCard(),

          ],
        ),
      ),
    );

    /*return Card(
      clipBehavior: Clip.antiAlias,
      child: ExpandableNotifier(
        child: Column(
          children: <Widget>[

            SizedBox(
              height: 150.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.rectangle,
                ),
                child: Image.asset(
                  post.image.path,
                ),
              ),
            ),

            ExpandablePanel(
                tapHeaderToExpand: true,

                header: Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 10.0),
                    child: Text(
                      post.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),

                collapsed: Text(post.text, softWrap: false, overflow: TextOverflow.ellipsis),
                expanded: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    Text(post.text, softWrap: true, overflow: TextOverflow.fade),

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

            ),

          ],
        ),
      ),
    );
    */
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

  Widget makeNoContentCard() {

  }

  Widget makeContentCard() {

  }

}