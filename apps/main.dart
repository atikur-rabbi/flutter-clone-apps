import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BBC News',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            title: Text('BBC News'),
            backgroundColor: Colors.red[900],
            centerTitle: true,
            leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
            actions: [
              IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
            ],
            bottom: PreferredSize(
              preferredSize: Size(0, 46),
              child: TabBar(
                isScrollable: true,
                tabs: [
                  Tab(
                    child: Text('Top Stories',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                  ),
                  Tab(
                    child: Text('Video',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                  ),
                  Tab(
                    child: Text('My News',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                  ),
                  Tab(
                    child: Text('Popular',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                  ),
                  Tab(
                    child: Text('Live',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              ListView(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                children: [
                  NewsFull(
                    title: 'The defining moment of the Trump presidency',
                    category: 'US Election 2020',
                    time: '51 mins ago',
                    image:
                    'https://ichef.bbci.co.uk/news/660/cpsprodpb/8DCA/production/_114789263_trump_salute976getty.jpg',
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      NewsCard(
                        title:
                        'False coronavirus claims and rumours about Trump',
                        category: 'US & Canada',
                        time: '5h',
                        image:
                        'https://ichef.bbci.co.uk/news/660/cpsprodpb/8AA8/production/_114769453_trumpreuters.jpg',
                      ),
                      SizedBox(width: 8.0),
                      NewsCard(
                        title: 'Trump ends Covid budget stimulus relief talks',
                        category: 'US & Canada',
                        time: '8h',
                        image:
                        'https://ichef.bbci.co.uk/news/660/cpsprodpb/D0AE/production/_114222435_gettyimages-1228234119.jpg',
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  NewsList(
                    title: 'Long Covid : Why are some people not recovering?',
                    category: 'Health',
                    time: '3h',
                    image:
                    'https://ichef.bbci.co.uk/news/660/cpsprodpb/753A/production/_114601003_gettyimages-694034013.jpg',
                  ),
                  SizedBox(height: 8.0),
                  NewsList(
                    title:
                    'Helicopter causes crash at Giro leaving rider with suspected broken back',
                    category: 'Sports',
                    time: '8h',
                    image:
                    'https://ichef.bbci.co.uk/onesport/cps/800/cpsprodpb/132A2/production/_114789487_gettyimages-1278808665.jpg',
                  ),
                  SizedBox(height: 8.0),
                ],
              ),
              Container(
                child: Center(child: Text('Video')),
              ),
              Container(
                child: Center(child: Text('My News')),
              ),
              Container(
                child: Center(child: Text('Popular')),
              ),
              Container(
                child: Center(child: Text('Live')),
              ),
            ],
          ),
        ));
  }
}

class NewsFull extends StatelessWidget {
  final String title;
  final String category;
  final String time;
  final String image;

  const NewsFull(
      {Key key,
        @required this.title,
        @required this.category,
        @required this.time,
        this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: size.width / 2 + 16.0,
            decoration: BoxDecoration(
              color: Colors.red[100],
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 8.0, right: 8.0, left: 8.0, bottom: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  height: 38.0,
                  child: Row(
                    children: [
                      Text(time,
                          style:
                          TextStyle(color: Colors.black, fontSize: 14.0)),
                      VerticalDivider(
                        color: Colors.black12,
                        width: 30.0,
                        thickness: 2.0,
                      ),
                      Text(category,
                          style: TextStyle(color: Colors.red, fontSize: 14.0)),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final String title;
  final String category;
  final String time;
  final String image;

  const NewsCard(
      {Key key,
        @required this.title,
        @required this.category,
        @required this.time,
        this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width / 2 - 12.0,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: size.width / 4,
            decoration: BoxDecoration(
              color: Colors.red[100],
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 97.0,
            padding: const EdgeInsets.only(
                top: 8.0, right: 8.0, left: 8.0, bottom: 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  height: 32.0,
                  child: Row(
                    children: [
                      Text(time,
                          style:
                          TextStyle(color: Colors.black, fontSize: 12.0)),
                      VerticalDivider(
                        color: Colors.black12,
                        width: 12.0,
                        thickness: 2.0,
                      ),
                      Text(category,
                          style: TextStyle(color: Colors.red, fontSize: 12.0)),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class NewsList extends StatelessWidget {
  final String title;
  final String category;
  final String time;
  final String image;

  const NewsList(
      {Key key,
        @required this.title,
        @required this.category,
        @required this.time,
        this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 97.0,
      child: Row(
        children: [
          Container(
            width: 170.0,
            decoration: BoxDecoration(
              color: Colors.red[100],
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, right: 8.0, left: 8.0, bottom: 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    height: 32.0,
                    child: Row(
                      children: [
                        Text(time,
                            style:
                            TextStyle(color: Colors.black, fontSize: 12.0)),
                        VerticalDivider(
                          color: Colors.black12,
                          width: 12.0,
                          thickness: 2.0,
                        ),
                        Text(category,
                            overflow: TextOverflow.ellipsis,
                            style:
                            TextStyle(color: Colors.red, fontSize: 12.0)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}