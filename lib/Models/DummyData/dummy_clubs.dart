import 'package:lhs_connections/Models/Club.dart';
import 'package:lhs_connections/Models/tags.dart';

import 'package:flutter/material.dart';

class DummyClubs {
  final List<Club> _dummyClubs = [
    Club("Robotics",  "Mrs. Lorey", Icons.android,
        [Tags.tech, Tags.engineering, Tags.robot]),
    Club("Marching Band",  "Mr. Wyss", Icons.audiotrack,
        [Tags.music]),
    Club("Set Crew", "Mr. Blackwood",Icons.weekend,
        [Tags.engineering, Tags.construction, Tags.perf_arts]),
  ];

  List<Club> get dummyClubs => _dummyClubs;
}