import 'dart:math';

import 'package:flutter/material.dart';

//Colors
Color crossColor = const Color(0xFF1ABDD5);
Color circleColor = const Color(0xFFD8B9FA);
Color accentColor = const Color(0xFF90A4AE);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TwoPlayerGame(),
    );
  }
}

enum GameState { Blank, X, O }

class TwoPlayerGame extends StatefulWidget {
  @override
  _TwoPlayerGameState createState() => _TwoPlayerGameState();
}

class _TwoPlayerGameState extends State<TwoPlayerGame>
    with TickerProviderStateMixin {
  var activePlayer = GameState.X;
  var winner = GameState.Blank;
  var boardState = List<List<GameState>>.generate(
      3, (i) => List<GameState>.generate(3, (j) => GameState.Blank));

  Animation<double> _boardAnimation;
  AnimationController _boardController;
  double _boardOpacity = 1.0;
  bool _showWinnerDisplay = false;
  int _moveCount = 0;
  int _xWins = 0;
  int _oWins = 0;
  int _draws = 0;

  @override
  void initState() {
    _boardController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _boardAnimation = Tween(begin: 1.0, end: 0.0).animate(_boardController)
      ..addListener(() {
        setState(() {
          _boardOpacity = _boardAnimation.value;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _boardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                scoreBoard,
                Padding(
                  padding: const EdgeInsets.only(
                      left: 100.0, right: 100.0, top: 40, bottom: 40),
                  child: Stack(
                    children: <Widget>[
                      board,
                      winnerDisplay,
                    ],
                  ),
                ),
                bottomBar,
              ],
            ),
          )),
    );
  }

  Widget get scoreBoard => Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            xScore,
            drawScore,
            oScore,
          ],
        ),
      );

  Widget get winnerDisplay => Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        child: Visibility(
          visible: _showWinnerDisplay,
          child: Opacity(
            opacity: 1.0 - _boardOpacity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (winner == GameState.X)
                  SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: Cross(),
                  ),
                if (winner == GameState.O)
                  SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: Circle(),
                  ),
                Text(
                  (winner == GameState.Blank) ? "It's a draw!" : 'win!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                    fontSize: 56.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget get xScore => Column(
        children: <Widget>[
          SizedBox(
            width: 80.0,
            height: 80.0,
            child: Cross(),
          ),
          Text(
            '$_xWins wins',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: crossColor,
              fontSize: 20.0,
            ),
          ),
        ],
      );

  Widget get oScore => Column(
        children: <Widget>[
          SizedBox(
            width: 80.0,
            height: 80.0,
            child: Circle(),
          ),
          Text(
            '$_oWins wins',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: circleColor,
                fontSize: 20.0),
          )
        ],
      );

  Widget get drawScore => Column(
        children: <Widget>[
          SizedBox(
            width: 80.0,
            height: 80.0,
            child: Equal(),
          ),
          Text(
            '$_draws draws',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: accentColor,
                fontSize: 20.0),
          )
        ],
      );

  Widget get board => Opacity(
        opacity: _boardOpacity,
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              color: Colors.grey[300],
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  int row = index ~/ 3;
                  int col = index % 3;
                  return gameButton(row, col);
                },
              ),
            ),
          ),
        ),
      );

  Widget get bottomBar => Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton(
              heroTag: 'reset',
              child: Icon(Icons.cached),
              backgroundColor: accentColor,
              mini: true,
              onPressed: () => reset(),
            ),
          ],
        ),
      );

  Widget gameButton(int row, int col) {
    return GestureDetector(
      onTap:
          (boardState[row][col] == GameState.Blank && winner == GameState.Blank)
              ? () {
                  _moveCount++;
                  boardState[row][col] = activePlayer;
                  checkWinningCondition(row, col, activePlayer);
                  toggleActivePlayer();
                  setState(() {});
                }
              : null,
      child: Container(
        color: Colors.white,
        child: Center(
          child: gamePiece(row, col),
        ),
      ),
    );
  }

  void toggleActivePlayer() {
    if (activePlayer == GameState.X)
      activePlayer = GameState.O;
    else
      activePlayer = GameState.X;
  }

  gamePiece(int row, int col) {
    if (boardState[row][col] == GameState.X)
      return Cross();
    else if (boardState[row][col] == GameState.O)
      return Circle();
    else
      return null;
  }

  void reset() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        boardState[i][j] = GameState.Blank;
      }
    }
    activePlayer = GameState.X;
    winner = GameState.Blank;
    _moveCount = 0;
    setState(() {
      _showWinnerDisplay = false;
    });
    _boardController.reverse();
  }

  void checkWinningCondition(int row, int col, GameState gameState) {
    //check col condition
    for (int i = 0; i < 3; i++) {
      if (boardState[row][i] != gameState) break;
      if (i == 2) {
        setWinner(gameState);
        return;
      }
    }

    //Check row condition
    for (int i = 0; i < 3; i++) {
      if (boardState[i][col] != gameState) break;
      if (i == 2) {
        setWinner(gameState);
        return;
      }
    }

    //check diagonal
    if (row == col) {
      for (int i = 0; i < 3; i++) {
        if (boardState[i][i] != gameState) break;
        if (i == 2) {
          setWinner(gameState);
          return;
        }
      }
    }

    // check anti-diagonal
    if (row + col == 2) {
      for (int i = 0; i < 3; i++) {
        if (boardState[i][2 - i] != gameState) break;
        if (i == 2) {
          setWinner(gameState);
          return;
        }
      }
    }

    //checkDraw
    if (_moveCount == 9) {
      print('Draw');
      setWinner(GameState.Blank);
      return;
    }
  }

  void setWinner(GameState gameState) {
    print('$gameState wins');
    winner = gameState;
    switch (gameState) {
      case GameState.Blank:
        {
          _draws++;
          break;
        }
      case GameState.X:
        {
          _xWins++;
          break;
        }
      case GameState.O:
        {
          _oWins++;
          break;
        }
    }
    toggleBoardOpacity();
  }

  void toggleBoardOpacity() {
    if (_boardOpacity == 0.0) {
      setState(() {
        _showWinnerDisplay = false;
      });
      _boardController.reverse();
    } else if (_boardOpacity == 1.0) {
      _boardController.forward();
      setState(() {
        _showWinnerDisplay = true;
      });
    }
  }
}

class Circle extends StatefulWidget {
  @override
  _CircleState createState() => _CircleState();
}

class _CircleState extends State<Circle> with SingleTickerProviderStateMixin {
  double _fraction = 0.0;
  Animation<double> _animation;
  AnimationController _controller;
  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _fraction = _animation.value;
        });
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: CustomPaint(
              painter: CirclePainter(fraction: _fraction),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CirclePainter extends CustomPainter {
  final double fraction;
  var _circlePaint;

  CirclePainter({this.fraction}) {
    _circlePaint = Paint()
      ..color = circleColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset(0.0, 0.0) & size;

    canvas.drawArc(rect, -pi / 2, pi * 2 * fraction, false, _circlePaint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate.fraction != fraction;
  }
}

class Cross extends StatefulWidget {
  @override
  _CrossState createState() => _CrossState();
}

class _CrossState extends State<Cross> with SingleTickerProviderStateMixin {
  double _fraction = 0.0;
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _fraction = _animation.value;
        });
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: CustomPaint(
              painter: CrossPainter(fraction: _fraction),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CrossPainter extends CustomPainter {
  final double fraction;
  var _crossPaint;

  CrossPainter({this.fraction}) {
    _crossPaint = Paint()
      ..color = crossColor
      ..strokeWidth = 12.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double leftLineFraction, rightLineFraction;

    if (fraction < .5) {
      leftLineFraction = fraction / .5;
      rightLineFraction = 0.0;
    } else {
      leftLineFraction = 1.0;
      rightLineFraction = (fraction - .5) / .5;
    }

    canvas.drawLine(
        Offset(0.0, 0.0),
        Offset(size.width * leftLineFraction, size.height * leftLineFraction),
        _crossPaint);

    if (fraction >= .5) {
      canvas.drawLine(
          Offset(size.width, 0.0),
          Offset(size.width - size.width * rightLineFraction,
              size.height * rightLineFraction),
          _crossPaint);
    }
  }

  @override
  bool shouldRepaint(CrossPainter oldDelegate) {
    return oldDelegate.fraction != fraction;
  }
}

class Equal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: CustomPaint(
            painter: EqualPainter(),
          ),
        ),
      ),
    );
  }
}

class EqualPainter extends CustomPainter {
  static double strokeWidth = 12.0;
  var _paint = Paint()
    ..color = accentColor
    ..strokeWidth = strokeWidth
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    var dy = (size.height - 2 * strokeWidth) / 3;
    canvas.drawLine(Offset(0.0, dy), Offset(size.width, dy), _paint);
    canvas.drawLine(Offset(0.0, 2 * dy + strokeWidth),
        Offset(size.width, 2 * dy + strokeWidth), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
