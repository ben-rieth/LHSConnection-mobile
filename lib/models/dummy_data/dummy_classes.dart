import 'package:lhs_connections/models/Class.dart';
import 'package:lhs_connections/models/tags.dart';

import 'package:flutter/material.dart';

class DummyClasses {
  final List<Class> _dummyClasses = [
    Class(name: "Symphonic Band", numCredit: .5, gradeLevels: [10, 11, 12], icon: Icons.audiotrack,
        tags: [Tags.music],
        requiredCourses: ["Previous Band Experience"]),
    Class(name: "AP Psychology", numCredit: 1, gradeLevels: [11, 12], icon: Icons.book,
        tags: [Tags.ap, Tags.soc_stud, Tags.psych]),
    Class(name: "AP Calculus", numCredit: 1, gradeLevels: [12], icon: Icons.assessment,
        tags: [Tags.ap, Tags.math, Tags.calc]),
    Class(name: "AP English Literature", numCredit: 1, gradeLevels: [12], icon: Icons.book,
        tags: [Tags.ap, Tags.english, Tags.rwi],
        description: apLitDescrip,
        requiredCourses: ["English 3*", "IB/Pre-AP English 3*", "AP Language*"]),
    Class(name: "AP Physics 2", numCredit: 1, icon: Icons.wb_incandescent, gradeLevels: [12],
        tags: [Tags.ap, Tags.ib, Tags.sci, Tags.physics, Tags.lab]),
    Class(name: "IB Computer Science 2", numCredit: 1, gradeLevels: [12], icon: Icons.computer,
        tags: [Tags.ib, Tags.prac_art, Tags.code, Tags.tech]),
    Class(name: "A+ Certification", numCredit: 1, gradeLevels: [10, 11, 12], icon: Icons.computer,
        tags: [Tags.comp, Tags.prac_art, Tags.comp_eng, Tags.tech]),
    Class(name: "AP Computer Science Principles", numCredit: 1, icon: Icons.computer,
        tags: [Tags.ap, Tags.comp, Tags.code, Tags.tech]),
    Class(name: "Computer Science Applications", numCredit: .5, icon: Icons.computer,
        tags: [Tags.code, Tags.comp, Tags.tech]),
    Class(name: "AP Computer Science 1", numCredit: 1, icon: Icons.computer,
        tags: [Tags.ap, Tags.code, Tags.comp, Tags.tech]),
  ];

  List<Class> get dummyClasses => _dummyClasses;

  static const String apLitDescrip = "This is a literature, discussion, and composition " +
  "course. After students read classic and modern " +
  "literature, they will discuss the material and write " +
  "short or extensive papers on the works. The texts " +
  "are supplemented by outside readings and critical " +
  "sections. This course also serves as the second " +
  "year in the IB Diploma Program.";

  static const String tokDescrip = "In some respects, the Theory of Knowledge (TOK) course focuses on problems of knowledge traditionally "
  +"addressed in philosophy classrooms: How do we know what we know? On what bases (e.g., moral, scientific, "
  +" aesthetic, theological) are different truth claims made? How and why do these truths claims overlap and/or "
  +" conflict? In addition, the course invites students to examine what have more recently been described as “crossdisciplinary” approaches to knowledge: How do we define the boundaries between “hard” and “soft” sciences? "
  +"What is at stake in recent controversies concerning the nature and functions of history? Who is fighting the socalled “culture wars”? Why? The Theory of Knowledge course is required for (and available only to) students "
  +"pursuing the International Baccalaureate diploma. This course will be graded on a pass/fail basis. ";
}