import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage>
    with SingleTickerProviderStateMixin {

  TextEditingController _textEditingController;
  TabController _tabController;

  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text("District Calander", style: TextStyle(color: Colors.green));

  @override
  void initState() {

    _textEditingController = TextEditingController();
    _tabController = TabController(length: 4, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[

        SliverAppBar(
          title: _appBarTitle,
          leading: IconButton(
              icon: _searchIcon,
              color: Colors.green,
              onPressed: _searchPressed,
          ),
          backgroundColor: Colors.grey[350],
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.green,
            unselectedLabelColor: Colors.white,
            indicatorColor: Colors.lightGreen,
            isScrollable: true,
            tabs: <Widget>[

              Tab(text: "CALANDER"),
              Tab(text: "EVENTS"),
              Tab(text: "SPORTS"),
              Tab(text: "FUNDRAISERS"),

            ],
          ),
        ),

      ],
    );
  }

  void _searchPressed() {
    setState(() {
      if(this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _textEditingController,
          autofocus: true,
          decoration: new InputDecoration(
            hintText: "Search Events",
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text("District Calander", style: TextStyle(color: Colors.green));
      }
    });
  }
}