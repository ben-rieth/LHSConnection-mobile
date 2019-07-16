import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:vector_math/vector_math_64.dart';

import 'package:Gamut/models/class.dart';
import 'package:Gamut/widgets/class_club_widgets/potential_class_screen.dart';

class ResultsPuruseScreen extends StatefulWidget {

  final List<Class> classes;
  final int initialPageIndex;

  ResultsPuruseScreen({
    @required this.classes,
    @required this.initialPageIndex,
    Key key})
      : super(key: key);

  State<ResultsPuruseScreen> createState() => _ResultsPuruseScreenState();
}

class _ResultsPuruseScreenState extends State<ResultsPuruseScreen> {

  IndexController _indexController;
  TransformerPageController _pageController;

  @override
  void initState() {
    super.initState();
    _indexController = IndexController();
    _pageController = TransformerPageController(initialPage: widget.initialPageIndex);


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: TransformerPageView(
        itemCount: widget.classes.length,
        pageSnapping: true,
        loop: true,
        controller: _indexController,
        pageController: _pageController,
        transformer: _ScaleAndFadeTransformer(),
        itemBuilder: (BuildContext context, int index) {
          return PotentialClassPage(potentialClass: widget.classes[index]);
        },
      ),
    );

  }

  @override
  void dispose() {
    _indexController.dispose();
    super.dispose();
  }

}

class _ScaleAndFadeTransformer extends PageTransformer {
  final double _scale;
  final double _fade;

  _ScaleAndFadeTransformer({double fade: 0.3, double scale: 0.8})
      : _fade = fade,
        _scale = scale;

  @override
  Widget transform(Widget item, TransformInfo info) {
    double position = info.position;
    double scaleFactor = (1 - position.abs()) * (1 - _scale);
    double fadeFactor = (1 - position.abs()) * (1 - _fade);
    double opacity = _fade + fadeFactor;
    double scale = _scale + scaleFactor;
    return new Opacity(
      opacity: opacity,
      child: new Transform.scale(
        scale: scale,
        child: item,
      ),
    );
  }
}