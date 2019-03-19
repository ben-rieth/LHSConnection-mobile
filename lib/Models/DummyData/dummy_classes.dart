import 'package:lhs_connections/Models/Class.dart';
import 'package:lhs_connections/Models/tags.dart';

import 'package:flutter/material.dart';

class DummyClasses {
  final List<Class> _dummyClasses = [
    Class("Symphonic Band", .5, Icons.audiotrack,
        [Tags.music]),
    Class("AP Psychology", 1, Icons.book,
        [Tags.ap, Tags.soc_stud, Tags.psych]),
    Class("AP Calculus", 1, Icons.assessment,
        [Tags.ap, Tags.math, Tags.calc]),
    Class("AP English Literature", 1, Icons.book,
        [Tags.ap, Tags.english, Tags.rwi]),
    Class("AP Physics 2", 1, Icons.wb_incandescent,
        [Tags.ap, Tags.ib, Tags.sci, Tags.physics, Tags.lab]),
    Class("IB Computer Science 2", 1, Icons.computer,
        [Tags.ib, Tags.prac_art, Tags.code, Tags.tech]),
    Class("A+ Certification", 1, Icons.computer,
        [Tags.comp, Tags.prac_art, Tags.comp_eng, Tags.tech]),
    Class("AP Computer Science Principles", 1, Icons.computer,
        [Tags.ap, Tags.comp, Tags.code, Tags.tech]),
    Class("COmputer Science Applications", .5, Icons.computer,
        [Tags.code, Tags.comp, Tags.tech]),
    Class("AP Computer Science 1", 1, Icons.computer,
        [Tags.ap, Tags.code, Tags.comp, Tags.tech]),
  ];

  List<Class> get dummyClasses => _dummyClasses;
}