import 'package:flutter/material.dart';

import 'package:lhs_connections/models/Class.dart';

class PotentialClassPage extends StatelessWidget {

  final Class potentialClass;

  PotentialClassPage({Key key, this.potentialClass}) : super(key : key);

  @override
  Widget build(BuildContext context) {

    final amountOfCredit = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: new BoxDecoration(
        border: new Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: new Center(
        child: Text(
          potentialClass.numCredit.toString(),
          style: TextStyle(color: Colors.white),
        )
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 55.0),
        Icon(
          potentialClass.icon,
          color: Colors.white,
          size: 40.0,
        ),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.yellowAccent),
        ),
        SizedBox(height: 10.0),
        Text(
          potentialClass.name,
          style: TextStyle(color: Colors.white, fontSize: 40.0),
        ),
        SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 6, child: makeTagSubtitle(potentialClass)),
            Expanded(flex: 1, child: amountOfCredit),
          ],
        ),

      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0),
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/desks.png"),
                fit: BoxFit.cover,)),
        ),

        Opacity(
          opacity: .7,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            padding: EdgeInsets.all(40.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.green),
          ),
        ),

        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: topContentText,
          ),
        ),

        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),

      ],
    );

    final bottomContent = Container(
      padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 30.0),
      child: Center(
        child: Text(
          potentialClass.description,
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );

    return Scaffold(
      body: ListView(
        children: <Widget>[
          topContent,
          bottomContent,

          Divider(
            color: Colors.lightGreen,
            height: 5.0,
          ),

          makeGradeLevelBox(),

          Divider(
            color: Colors.lightGreen,
            height: 5.0,
          ),

          makePrerequisites(),

        ],
      ),
    );
  }

  Widget makeGradeLevelBox() {

    String gradeLevels = "";

    potentialClass.gradeLevels.forEach((gradeLevel) {

      if(gradeLevel == 9) {
        gradeLevels += "Freshman, ";
      } else if(gradeLevel == 10) {
        gradeLevels += "Sophmore, ";
      } else if(gradeLevel == 11) {
        gradeLevels += "Junior, ";
      } else if(gradeLevel == 12) {
        gradeLevels += "Senior, ";
      }

    });

    gradeLevels = gradeLevels.substring(0, gradeLevels.length-2);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child:Center(
        child: Column(
          children: <Widget>[

            Text(
              "Required Grade Level",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[400])
            ),

            SizedBox(height: 5.0),

            Text(
              gradeLevels,
              style: TextStyle(fontSize: 20.0)
            ),

          ],
        ),
      ),
    );
  }

  Widget makePrerequisites() {
    bool addOrExplanation = false;

    potentialClass.requiredCourses.forEach((item) {
      if(item.contains("*")) {
        addOrExplanation = true;
      }
    });

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child:Center(
        child: Column(
          children: <Widget>[

            Text(
                "Prerequisites",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[400])
            ),

            //SizedBox(height: 5.0),

            ListView.builder(
              shrinkWrap: true,
              itemCount: potentialClass.requiredCourses.length,
              itemExtent: 20.0,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Center(
                      child: Text(
                        potentialClass.requiredCourses[index],
                        style: TextStyle(fontSize: 20.0))
                  ),
                );
              },
            ),

            SizedBox(height: 30.0),

            addOrExplanation ?
                Center(
                  child: Text(
                    "* Only one of these classes required",
                    style: TextStyle(color: Colors.grey[400], fontSize: 12.0),
                  ),
                ) : Container(),

            SizedBox(height: 20.0),

          ],
        ),
      ),
    );
  }

  Text makeTagSubtitle(Class potentialClass) {
    String tagSubtitle = "";

    potentialClass.tags.forEach((tag) {
      tagSubtitle += "$tag, ";
    });

    tagSubtitle = tagSubtitle.trim();
    tagSubtitle = tagSubtitle.substring(0, tagSubtitle.length - 1);

    return Text(tagSubtitle, style: TextStyle(color: Colors.white));
  }

}