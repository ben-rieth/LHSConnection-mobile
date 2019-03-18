import 'package:lhs_connections/Models/Club.dart';
import 'package:lhs_connections/Models/tags.dart';

import 'package:flutter/material.dart';

class DummyClubs {
  final List<Club> _dummyClubs = [
    Club(name: "Robotics", icon: Icons.android, sponsor: "Mrs. Lorey", tags: [Tags.tech, Tags.engineering, Tags.robot]),
    Club(name: "Marching Band", icon: Icons.audiotrack, sponsor: "Mr. Wyss", tags: [Tags.music]),
    Club(name: "Set Crew", icon: Icons.weekend, sponsor: "Mr. Blackwood", tags: [Tags.engineering, Tags.construction, Tags.perf_arts]),
  ];

  List<Club> get dummyClubs => _dummyClubs;
}