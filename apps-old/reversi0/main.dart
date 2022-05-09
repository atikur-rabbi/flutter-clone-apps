import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

String title = "Reversi";

void main() {
  runApp(Reversi());
}

class Reversi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: title),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String difficulty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text("Welcome to Reversi", style: TextStyle(fontSize: 24),),
          DropdownButton<String>(
            value: difficulty,
            onChanged: (String newValue) {
              setState(() {
                difficulty = newValue;
              });
            },
            items: <String>['Easy', 'Medium', 'Hard']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            hint: Text('Select AI Level'),
          ),
          Center(
            child: RaisedButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GamePage(title: widget.title, difficulty: difficulty)
                    )
                );
              },
              color: Colors.greenAccent,
              child: Text("New Game", style: TextStyle(fontSize: 24),),
            ),
          )
        ],
      ),
    );
  }
}























const int BOARD_SIZE = 8;
const int X = 1;
const int O = -1;
const int EMPTY = 0;
const int INF = 2000000000; // infinity

const Color EmptyCellColor = Colors.white10;
const CellColors = {X: Colors.black54, O: Colors.red};
const PlayerNames = {X: "Black", O: "Red"};
const ThinkingDepth = {"Easy": 1, "Medium": 2, "Hard": 4};

class GamePage extends StatefulWidget {
  final String title;
  final String difficulty;

  GamePage({this.title, this.difficulty = "Easy"});

  @override
  GamePageState createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  List<List> board;
  int _currentPlayer;
  var _cnt;
  String _info;
  int _thinkingDepth;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() {
    _currentPlayer = X;
    board = List.generate(BOARD_SIZE, (i) => List.generate(BOARD_SIZE, (j) => 0));


    _put(3, 3, O);
    _put(3, 4, X);
    _put(4, 3, X);
    _put(4, 4, O);

    _cnt = {X: 2, O: 2};

    _info = '';
    _thinkingDepth = ThinkingDepth[widget.difficulty];
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => afterBuild(context));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildBoard(),
        ),
      ),
    );
  }

  void afterBuild(BuildContext context) {
    if (_currentPlayer == O) {
      var timer = Timer(Duration(seconds: 1), () => _AImove());
    }
  }

  void _AImove() {
    Move m = _findBestMove(_currentPlayer, _thinkingDepth, -INF, INF, _currentPlayer);
    _update(m.x, m.y);
  }

  List<Widget> _buildBoard() {
    List<Widget> L = List<Widget>();
    for(int i=0; i<BOARD_SIZE; i++) {
      L.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildRow(i),
      ));
    }
    L.add(Container(
        margin: EdgeInsets.only(top: 20),
        child: Text('$_info', style: TextStyle(fontSize: 18),)
    ));
    return L;
  }

  List<Widget> _buildRow(int r) {
    List<Widget> L = List<Widget>();
    for(int i=0; i<BOARD_SIZE; i++) {
      L.add(_buildCell(r, i));
    }
    return L;
  }

  Widget _buildCell(int r, int c) {
    return GestureDetector(
      onTap: () => _userMove(r, c),
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.all(1),
        decoration: BoxDecoration(
          border: _getBorder(r, c),
          color: EmptyCellColor,
        ),
        child: _buildPeg(r, c),
      ),
    );
  }

  _getBorder(int r, int c) {
    if (_currentPlayer == X && _isValid(r, c, X))
      return Border.all(color: Colors.green, width: 2);
    return Border.all(color: Colors.grey, width: 1);
  }

  Widget _buildPeg(int r, int c) {
    if (board[r][c] == EMPTY)
      return null;
    return Container(
      decoration: BoxDecoration(
        color: CellColors[board[r][c]],
        shape: BoxShape.circle,
      ),
    );
  }

  void _put(int i, int j, int peg) {
    board[i][j] = peg;
  }

  _userMove(int r, int c) {
    _update(r, c);
  }

  void _update(int r, int c) {
    if (!_isValid(r, c, _currentPlayer)) return;

    setState(() {
      _move(r, c, _currentPlayer);
      var w = _winner();
      if (w == X || w == O) {
        String s = PlayerNames[w];
        _info = "$s won";
      } else if (!_hasValidMove(-_currentPlayer)) {
        String current = PlayerNames[_currentPlayer];
        String opponent = PlayerNames[-_currentPlayer];
        _info = "$opponent doesn't have a valid move!\n $current should play again!";
      } else {
        _currentPlayer = -_currentPlayer;
        _info = '';
      }
    });
  }

  bool _inRange(int x, int y) {
    return (x >= 0 && x < BOARD_SIZE && y >= 0 && y < BOARD_SIZE);
  }

  bool _isValid(int x, int y, int player) {
    if (!_inRange(x, y))  return false;
    if (board[x][y] != EMPTY) return false;

    for(int dx=-1; dx<=1; dx++)
      for(int dy=-1; dy<=1; dy++) {
        var opponent = false, self = false;
        for(int i=x+dx,j=y+dy; _inRange(i, j); i+=dx,j+=dy) {
          if (board[i][j] == EMPTY) break;
          if (board[i][j] == player) {
            self = true;
            break;
          } else
            opponent = true;
        }
        if (self && opponent) return true;
      }
    return false;
  }

  bool _hasValidMove(int player) {
    // one of the players has no pegs left
    if (_cnt[X] == 0 || _cnt[O] == 0)
      return false;
    // there are no empty cells
    if (_cnt[X] + _cnt[O] == BOARD_SIZE*BOARD_SIZE)
      return false;

    for(int i=0; i<BOARD_SIZE; i++)
      for(int j=0; j<BOARD_SIZE; j++)
        if (_isValid(i, j, player))
          return true;

     return false;
  }

  int _winner() {
    // if one of the players has a valid move, the game is not finished
    if (!_hasValidMove(X) && !_hasValidMove(O))
      return (_cnt[X] > _cnt[O] ? X : _cnt[X] < _cnt[O] ? O : 0);
    return INF;
  }


  void _move(int x, int y, int player) {
    board[x][y] = player;

    _cnt[player]++;
    for(int dx=-1; dx<=1; dx++)
      for(int dy=-1; dy<=1; dy++) {
        var opponent = false, self = false;
        int i = x+dx, j = y+dy;
        for(; _inRange(i, j); i+=dx,j+=dy) {
          if (board[i][j] == EMPTY) break;
          if (board[i][j] == player) { self = true; break; }
          else opponent = true;
        }
        if (self && opponent)
          for(int I=x+dx,J=y+dy; I!=i || J!=j; I+=dx,J+=dy) {
            board[I][J] = player;
            _cnt[X] += player;
            _cnt[O] -= player;
          }
      }
  }

  int _score(player) {
    var weight = [
      [ 5,  2,  2,  2,  2,  2,  2,  5],
      [ 2, -1, -1, -1, -1, -1, -1,  2],
      [ 2, -1,  1,  1,  1,  1, -1,  2],
      [ 2, -1,  1,  1,  1,  1, -1,  2],
      [ 2, -1,  1,  1,  1,  1, -1,  2],
      [ 2, -1,  1,  1,  1,  1, -1,  2],
      [ 2, -1, -1, -1, -1, -1, -1,  2],
      [ 5,  2,  2,  2,  2,  2,  2,  5],
    ];

    weight[1][1] = weight[1][0] = weight[0][1] = (board[0][0] == player) ? 2 : -1;
    weight[1][6] = weight[1][7] = weight[0][6] = (board[0][7] == player) ? 2 : -1;
    weight[6][1] = weight[7][1] = weight[6][0] = (board[7][0] == player) ? 2 : -1;
    weight[6][6] = weight[7][6] = weight[6][7] = (board[7][7] == player) ? 2 : -1;

    int s = 0;
    for(int i=0; i<BOARD_SIZE; i++)
      for(int j=0; j<BOARD_SIZE; j++)
        s += (board[i][j] == player ? 1 : board[i][j] == -player ? -1 : 0) * weight[i][j];

    return s;
  }

  Move _findBestMove(int player, int depth, int alpha, int beta, int maxPlayer) {
    var w = _winner();
    if (w != INF) {
      var val = (w == 0 ? 0 : w == maxPlayer ? INF : -INF);
      return Move(score: val);
    }

    if (depth == 0) return Move(score: _score(maxPlayer));

    var cut = false;
    var xx = -1, yy = -1;
    var tmpBoard, tmpCnt;
    var notMoved = true;

    for(int i=0; i<BOARD_SIZE && !cut; i++)
      for(int j=0; j<BOARD_SIZE && !cut; j++) {
        if (!_isValid(i, j, player)) continue;
        if (xx == -1) { xx = i; yy = j; }

        tmpBoard = [for(var L in board) [...L]];
        tmpCnt = Map.from(_cnt);

        _move(i, j, player);
        notMoved = false;
        var r = _findBestMove(-player, depth-1, alpha, beta, maxPlayer);

        board = [for(var L in tmpBoard) [...L]];
        _cnt = Map.from(tmpCnt);

        if (player == maxPlayer) {
          if (r.score > alpha) {
            alpha = r.score;
            xx = i;
            yy = j;
          }
        }
        else {
          if (r.score < beta)
            beta = r.score;
        }

        if (beta <= alpha)
          cut = true;
      }

    if (notMoved) {
      tmpBoard = [for(var L in board) [...L]];
      tmpCnt = Map.from(_cnt);

      var r = _findBestMove(-player, depth-1, alpha, beta, maxPlayer);

      board = [for(var L in tmpBoard) [...L]];
      _cnt = Map.from(tmpCnt);

      if (player == maxPlayer) {
        if (r.score > alpha) alpha = r.score;
      }
      else {
        if (r.score < beta) beta = r.score;
      }
    }

    if (player == maxPlayer) {
      return Move(score: alpha, x: xx, y: yy);
    }

    return Move(score: beta, x: xx, y: yy);
  }

}

class Move {
  int score;
  int x;
  int y;

  Move({this.score, this.x = -1, this.y = -1});
}

