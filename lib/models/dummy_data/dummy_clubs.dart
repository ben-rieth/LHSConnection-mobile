import 'package:lhs_connections/models/Club.dart';
import 'package:lhs_connections/models/tags.dart';

import 'package:flutter/material.dart';

class DummyClubs {
  final List<Club> _dummyClubs = [
    Club(name: "Robotics", sponsor: "Mrs. Lorey", icon: Icons.android,
        tags: [Tags.tech, Tags.engineering, Tags.robot]),
    Club(name: "Marching Band",  sponsor: "Mr. Wyss", icon: Icons.audiotrack,
        tags: [Tags.music]),
    Club(name: "Set Crew", sponsor: "Mr. Blackwood", icon: Icons.weekend,
        tags: [Tags.engineering, Tags.construction, Tags.perf_arts]),
  ];

  List<Club> get dummyClubs => _dummyClubs;
}