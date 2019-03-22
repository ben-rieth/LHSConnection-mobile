import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';

//import 'package:lhs_connections/widgets/custom_widgets/custom_expansion_tile.dart' as custom;

class AccountPage extends StatefulWidget {
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with SingleTickerProviderStateMixin {

  TabController _tabController;

  final List<String> _clubList = ["Robotics", "Marching Band", "Theater"];
  final List<String> _classList = ["Symponic Band", "AP Psychology",
    "AP Calculus AB", "AP Literature", "AP Physics 2", "IB Computer Science 2",
    "A+ Certification"];
  final List<String> _interestList = ["Guitar", "Music", "Reading", "Computers"];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SwipeDetector(
      onSwipeLeft: _swipeLeft,
      onSwipeRight: _swipeRight,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: <Widget>[

              Center(
                child: CircleAvatar(
                  child: Text("Picture"),
                  radius: 50.0,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Center(
                  child: Text(
                    "Name Goes Here",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Center(
                  child: Text(
                    "Grade Level",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),

              TabBar(
                tabs: [
                  Tab(text: "CLASSES"),
                  Tab(text: "CLUBS"),
                  Tab(text: "INTERESTS"),
                ],
                labelColor: Colors.green,
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: EdgeInsets.all(5.0),
                indicatorColor: Colors.lightGreen,
                controller: _tabController,
              ),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget> [

                    _buildAccountViews(_classList),
                    _buildAccountViews(_clubList),
                    _buildAccountViews(_interestList),

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );

  }

  void _swipeLeft() {
    setState(() {
      if(_tabController.index+1 <= 2) {
        _tabController.animateTo(_tabController.index+1);
      }
    });
  }

  void _swipeRight() {
    setState(() {
      if(_tabController.index-1 >= 0) {
        _tabController.animateTo(_tabController.index-1);
      }
    });
  }

  Widget _buildAccountViews(List type) {
    return ListView.builder(
      itemCount: type.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(type[index]),
        );
      },
    );
  }

}