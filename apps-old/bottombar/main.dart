import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class SimpleAnimatedBottomTabBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SimpleAnimatedBottomTabBarState();
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
      bottomNavigationBar: SimpleAnimatedBottomTabBar(),
    );
  }
}

class SimpleAnimatedBottomTabBarState extends State<SimpleAnimatedBottomTabBar>
    with TickerProviderStateMixin {
  int currentIndex = 0;
  int previousIndex;
  List<String> tabOptions = ['Home', 'Stats', 'Events', 'History'];
  List<int> flexValues = [150, 100, 100, 100];
  List<double> opacityValues = [1.0, 0.0, 0.0, 0.0];
  List<double> verticalShiftValues = [-4.0, 8.0, 8.0, 8.0];
  List<double> iconsizeValues = [24.0, 22.0, 22.0, 22.0];
  List<double> fractionalOffsetValues = [0.0, 0.0, 0.0, 0.0];
  List<double> skewValues = [0.0, 0.0, 0.0, 0.0];
  AnimationController _controller;
  Animation animation;
  Animation skewFirstHalfAnimation;
  Animation skewSecondHalfAnimation;
  Animation shiftFirstHalfAnimation;
  Animation shiftSecondHalfAnimation;
  Animation opacityFirstHalfAnimation;
  Animation opacitySecondHalfAnimation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    animation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(curve: Curves.easeInOut, parent: _controller));
    shiftFirstHalfAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            curve: Interval(0.0, 0.85, curve: Curves.easeIn),
            parent: _controller));
    shiftSecondHalfAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            curve: Interval(0.15, 1.0, curve: Curves.easeOut),
            parent: _controller));
    opacityFirstHalfAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            curve: Interval(0.0, 0.50, curve: Curves.easeIn),
            parent: _controller));
    opacitySecondHalfAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            curve: Interval(0.50, 1.0, curve: Curves.easeOut),
            parent: _controller));

    skewFirstHalfAnimation = Tween<double>(begin: 0.0, end: 0.1).animate(
        CurvedAnimation(
            curve: Interval(0.0, 0.3, curve: Curves.easeIn),
            parent: _controller));
    skewSecondHalfAnimation = Tween<double>(begin: 0.0, end: 0.1).animate(
        CurvedAnimation(
            curve: Interval(0.7, 1.0, curve: Curves.easeOut),
            parent: _controller));

    animation.addListener(() {
      setState(() {
        flexValues[currentIndex] = 100 + (50 * animation.value).toInt();
        flexValues[previousIndex] = 100 + (50 * (1 - animation.value)).toInt();
        opacityValues[currentIndex] = opacitySecondHalfAnimation.value;
        opacityValues[previousIndex] = (1 - opacityFirstHalfAnimation.value);
        verticalShiftValues[currentIndex] = 8 - (12 * animation.value);
        verticalShiftValues[previousIndex] = -4 + (12 * animation.value);
        iconsizeValues[currentIndex] = 22 + (2 * animation.value);
        iconsizeValues[previousIndex] = 22 + (2 * (1 - animation.value));
        if (currentIndex > previousIndex) {
          fractionalOffsetValues[currentIndex] =
              -1 + shiftSecondHalfAnimation.value;
          fractionalOffsetValues[previousIndex] = shiftFirstHalfAnimation.value;
          skewValues[currentIndex] =
              skewFirstHalfAnimation.value - skewSecondHalfAnimation.value;
          skewValues[previousIndex] =
              -skewFirstHalfAnimation.value + skewSecondHalfAnimation.value;
        } else if (currentIndex < previousIndex) {
          fractionalOffsetValues[currentIndex] =
              1 - shiftSecondHalfAnimation.value;
          fractionalOffsetValues[previousIndex] =
              -shiftFirstHalfAnimation.value;
          skewValues[currentIndex] =
              -skewFirstHalfAnimation.value + skewSecondHalfAnimation.value;
          skewValues[previousIndex] =
              skewFirstHalfAnimation.value - skewSecondHalfAnimation.value;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        color: Colors.white,
        height: 56.0,
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              flex: flexValues[0],
              fit: FlexFit.tight,
              child: FlatButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  clipBehavior: Clip.none,
                  onPressed: () {
                    _onIconClicked(pressedIndex: 0);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(0.0, verticalShiftValues[0]),
                        child: Transform(
                          transform: Matrix4.skewY(skewValues[0]),
                          child: Icon(
                            Icons.home,
                            size: iconsizeValues[0],
                          ),
                        ),
                      ),
                      ClipRect(
                        child: FractionalTranslation(
                          translation: Offset(fractionalOffsetValues[0], 0.0),
                          child: Opacity(
                            opacity: opacityValues[0],
                            child: Center(
                                child: Text(tabOptions[0],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400))),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            Flexible(
              flex: flexValues[1],
              fit: FlexFit.tight,
              child: FlatButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                clipBehavior: Clip.none,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(0.0, verticalShiftValues[1]),
                      child: Transform(
                        transform: Matrix4.skewY(skewValues[1]),
                        child: Icon(
                          Icons.timeline,
                          size: iconsizeValues[1],
                        ),
                      ),
                    ),
                    ClipRect(
                      child: FractionalTranslation(
                        translation: Offset(fractionalOffsetValues[1], 0.0),
                        child: Opacity(
                          opacity: opacityValues[1],
                          child: Center(
                              child: Text(tabOptions[1],
                                  style:
                                      TextStyle(fontWeight: FontWeight.w400))),
                        ),
                      ),
                    )
                  ],
                ),
                onPressed: () {
                  _onIconClicked(pressedIndex: 1);
                },
              ),
            ),
            Flexible(
              flex: flexValues[2],
              fit: FlexFit.tight,
              child: FlatButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                clipBehavior: Clip.none,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(0.0, verticalShiftValues[2]),
                      child: Transform(
                        transform: Matrix4.skewY(skewValues[2]),
                        child: Icon(
                          Icons.event,
                          size: iconsizeValues[2],
                        ),
                      ),
                    ),
                    ClipRect(
                      child: FractionalTranslation(
                        translation: Offset(fractionalOffsetValues[2], 0.0),
                        child: Opacity(
                          opacity: opacityValues[2],
                          child: Center(
                              child: Text(
                            tabOptions[2],
                            style: TextStyle(fontWeight: FontWeight.w400),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
                onPressed: () {
                  _onIconClicked(pressedIndex: 2);
                },
              ),
            ),
            Flexible(
              flex: flexValues[3],
              fit: FlexFit.tight,
              child: FlatButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                clipBehavior: Clip.none,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(0.0, verticalShiftValues[3]),
                      child: Transform(
                        transform: Matrix4.skewY(skewValues[3]),
                        child: Icon(
                          Icons.history,
                          size: iconsizeValues[3],
                        ),
                      ),
                    ),
                    ClipRect(
                      child: FractionalTranslation(
                        translation: Offset(fractionalOffsetValues[3], 0.0),
                        child: Opacity(
                          opacity: opacityValues[3],
                          child: Center(
                              child: Text(tabOptions[3],
                                  style:
                                      TextStyle(fontWeight: FontWeight.w400))),
                        ),
                      ),
                    )
                  ],
                ),
                onPressed: () {
                  _onIconClicked(pressedIndex: 3);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _onIconClicked({int pressedIndex}) {
    if (pressedIndex != currentIndex) {
      previousIndex = currentIndex;
      currentIndex = pressedIndex;
      _controller.reset();
      _controller.forward();
    }
  }
}