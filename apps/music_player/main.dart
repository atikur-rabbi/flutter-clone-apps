//import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';

var imageurl = "https://atikur-rabbi.github.io/clone-apps/apps/music_player/assets/images/";

const kTrandingText = TextStyle(
  fontSize: 14.0,
  fontFamily: 'Campton_Light',
  fontWeight: FontWeight.w800,
  // height: -10,
  color: Color(0xFF7D9AFF),
);

const kArtistNameText = TextStyle(
  fontSize: 72.0,
  height: 2,
  fontFamily: 'CoralPen',
  color: Colors.white,
);

const Ktitle = TextStyle(
  color: Colors.black,
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  fontFamily: 'Campton_Light',
);

const kShowAllText = TextStyle(
  fontSize: 16.0,
  color: Color(0xFF7D9AFF),
  fontWeight: FontWeight.w600,
  fontFamily: 'Campton_Light',
);

const kDuration =
    TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w800);



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xFF7D9AFF),
        accentColor: Color(0xFF7D9AFF),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/player': (context) => MusicPlayer(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              AlbumCover(),
              TopAppBAr(
                iconName: Icons.menu,
              ),
              ArtistName(),
              Positioned(
                bottom: -25,
                right: 30,
                child: FloatingActionButton(
                  backgroundColor: Color(0xFF7D9AFF),
                  onPressed: () {
                    // Todo What you want to
                  },
                  child: Icon(Icons.play_arrow),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Popular',
                      style: Ktitle,
                    ),
                    Text(
                      'Show All',
                      style: kShowAllText,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: <Widget>[
                      SongList(
                        songName: 'No tears to cry',
                        songDuration: 5.20,
                      ),
                      SongList(
                        songName: 'Imagine',
                        songDuration: 3.20,
                      ),
                      SongList(
                        songName: 'Into you',
                        songDuration: 4.12,
                      ),
                      // SongList(
                      //   songName: 'One lasr time',
                      //   songDuration: 4.55,
                      // )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}



class MusicPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          BlurBackground(),
          TopAppBAr(
            iconName:
                Icons.arrow_back ,
          ),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).padding.top + 100),
            width: double.infinity,
            // color: Colors.teal,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(48), topRight: Radius.circular(48)),
            ),
            child: Column(
              children: <Widget>[
                ArtistPhoto(),
                ProcessBar(),
                SongsDuration(),
                SongsName(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(
                        Icons.fast_rewind,
                        size: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey.withOpacity(.5),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(25),
                          child: Icon(
                            Icons.pause,
                            size: 30,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.fast_forward,
                        size: 30,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SongsName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: <Widget>[
          Text(
            'No tears left to cry',
            style: Ktitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Ariana Grande',
            style: kShowAllText,
          ),
        ],
      ),
    );
  }
}

class SongsDuration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '3.52',
            style: kDuration,
          ),
          Text(
            '5.20',
            style: kDuration,
          ),
        ],
      ),
    );
  }
}

class ProcessBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 2.5,
      width: MediaQuery.of(context).size.width - 20,
      child: LinearProgressIndicator(
        value: .7,
        valueColor: AlwaysStoppedAnimation<Color>(
          Color(0xFF7D9AFF),
        ),
        backgroundColor: Colors.grey.withOpacity(0.2),
      ),
    );
  }
}

class ArtistPhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 20),
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        image: DecorationImage(
          image: NetworkImage(imageurl + 'ariana_grande_artist_photo_3.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class BlurBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .6,
      width: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          image: NetworkImage(imageurl + 'ariana_grande_cover_no_tears_left_to_cry.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.0),
          ),
        ),
      ),
    );
  }
}



class AlbumCover extends StatelessWidget {
  const AlbumCover({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .6,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
        ),
        image: DecorationImage(
          image: NetworkImage(imageurl + 'ariana_grande_cover_no_tears_left_to_cry.jpg'), 
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ArtistName extends StatelessWidget {
  const ArtistName({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .6,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            children: <Widget>[
              Positioned(
                bottom: 170,
                child: Text(
                  'Tranding',
                  style: kTrandingText,
                ),
              ),
              Positioned(
                bottom: 80,
                child: Text(
                  'Ariana',
                  style: kArtistNameText,
                ),
              ),
              Positioned(
                bottom: 20,
                child: Text(
                  'Grande',
                  style: kArtistNameText,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}




class SongList extends StatelessWidget {
  SongList({@required this.songName, @required this.songDuration});

  final String songName;
  final double songDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: GestureDetector(
                  onTap: () {
                    // Do something when click the song name
                    Navigator.pushNamed(context, '/player');
                  },
                  child: Text(
                    '$songName',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Campton_Light'),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  songDuration.toStringAsFixed(2),
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Do something when click the menu
                  },
                  child: Icon(
                    Icons.more_horiz,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          // width: MediaQuery.of(context).size.width * .8,
          padding: EdgeInsets.only(
            top: 10,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Colors.grey[300],
              ),
            ),
          ),
        )
      ],
    );
  }
}




class TopAppBAr extends StatelessWidget {
  TopAppBAr({this.iconName});
  final IconData iconName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 16, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            iconName,
            color: Colors.white,
          ),
          Icon(
            Icons.info_outline,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

