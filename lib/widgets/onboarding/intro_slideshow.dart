import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:dots_indicator/dots_indicator.dart';

class IntroSlideshowScreen extends StatefulWidget {
  State<IntroSlideshowScreen> createState() => _IntroSlideshowScreenState();
}

class _IntroSlideshowScreenState extends State<IntroSlideshowScreen> {

  int _slideIndex = 0;

  final List<String> images = [
    "assets/gamut.png",
    "assets/interests.png",
    "assets/annoucements.png",
    "assets/survey.png",
    "assets/go.jpg"
  ];

  final List<String> headerText = [
    "Welcome to Gamut-Lindbergh!",
    "Find your passions!",
    "Stay Connected!",
    "Have a Say!",
    "Let's Get Started!"
  ];

  final List<String> subText = [
    "Opportunities Await!",
    "Search for classes and clubs that match your interests",
    "Recieve annoucements directly on your phone",
    "Take surveys to voice your opinions",
    "Let's learn what you love!"
  ];

  final IndexController _indexController = IndexController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: TransformerPageView(
        itemCount: 5,
        pageSnapping: true,
        onPageChanged: (index) {
          setState(() {
            this._slideIndex = index;
          });
        },
        loop: false,
        controller: _indexController,

        transformer: PageTransformerBuilder(
          builder: (Widget child, TransformInfo info) {

            return Material(
              color: Colors.white,
              elevation: 8.0,
              textStyle: TextStyle(color: Colors.white),
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      ParallaxContainer(
                        position: info.position,
                        opacityFactor: .8,
                        translationFactor: 400.0,
                        child: Text(
                          headerText[info.index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 34.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(height: 40.0),

                      ParallaxContainer(
                        position: info.position,
                        translationFactor: 400.0,
                        child: Image.asset(
                          images[info.index],
                          fit: BoxFit.contain,
                          height: 350,
                        ),
                      ),

                      SizedBox(height: 40.0),

                      ParallaxContainer(
                        position: info.position,
                        translationFactor: 300.0,
                        child: Text(
                          subText[info.index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                      SizedBox(height: 25.0),

                      ParallaxContainer(
                        position: info.position,
                        translationFactor: 400.0,
                        child: DotsIndicator(
                          dotsCount: 5,
                          position: _slideIndex,
                          decorator: DotsDecorator(
                            color: Colors.grey[600],
                            activeColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),

                      SizedBox(height: 25.0),

                      _slideIndex == 4 ?
                        ParallaxContainer(
                          position: info.position,
                          translationFactor: 400.0,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: FlatButton(
                              child: Text(
                                "CONTINUE",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20.0,
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ) : ParallaxContainer(position: info.position, child: Container()),

                    ],
                  ),
                ),
              ),
            );

          }
        ),

      ),
    );

  }
}
