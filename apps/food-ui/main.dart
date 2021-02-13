import 'package:flutter/material.dart';

var imageurl = "https://atikur-rabbi.github.io/clone-apps/apps/food-ui/assets/images/";

const Color kMainColor = Color(0xFF21BFBD);
const Color kSecondaryColor = Color(0xFF7fa1fa);

const TextStyle kHeading = TextStyle(
  fontFamily: 'Montserrat',
  color: Colors.white,
  fontSize: 35,
  fontWeight: FontWeight.w700,
);

const TextStyle kHeadingLight = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 35,
  color: Colors.white,
  fontWeight: FontWeight.w300,
);

const TextStyle kHeadingSmall = TextStyle(
  fontFamily: 'Montserrat',
  color: Colors.black,
  fontWeight: FontWeight.w700,
  fontSize: 18,
);

const TextStyle kPriceText = TextStyle(
  fontFamily: "Montserrat",
  fontWeight: FontWeight.w700,
  fontSize: 14,
  color: Colors.grey,
);

const TextStyle kNormalText = TextStyle(
  fontFamily: "WorkSans",
  fontWeight: FontWeight.w600,
  fontSize: 14,
  color: Colors.grey,
);


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: kMainColor,
        body: SafeArea(
          child: HomeScreen(),
        ),
      ),
    );
  }
}


class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWight = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text(
          "Details",
          style: kHeadingSmall.copyWith(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_list),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 75.0,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45.0),
                    topRight: Radius.circular(45.0),
                  ),
                  color: Colors.white),
              // height: screenHeight - 10.0,
              width: screenWight,
              margin: EdgeInsets.only(bottom: 45),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: screenHeight * .2 + 10,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Avocado',
                            style: kHeading.copyWith(color: Colors.black),
                          ),
                          TextSpan(
                            text: ' Bowl',
                            style: kHeadingLight.copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '\$24.00',
                          style: kPriceText.copyWith(fontSize: 25),
                        ),
                        Container(
                            height: 30.0,
                            color: Colors.grey.withOpacity(.6),
                            width: 1.0),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            height: 40,
                            width: 120,
                            color: kSecondaryColor,
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                                Text(
                                  '2',
                                  style: kHeadingSmall.copyWith(
                                      color: Colors.white),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(7),
                                  child: Container(
                                    padding: EdgeInsets.all(1),
                                    color: Colors.white,
                                    child: Icon(
                                      Icons.add,
                                      color: kSecondaryColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        child: Row(
                          children: <Widget>[
                            ScroolCard(
                              select: true,
                              title: 'WEIGHT',
                              ammount: "300",
                              unit: 'G',
                            ),
                            ScroolCard(
                              select: false,
                              title: 'Calories',
                              ammount: "267",
                              unit: 'Cal',
                            ),
                            ScroolCard(
                              select: false,
                              title: 'Vitamins',
                              ammount: "A, B6",
                              unit: 'VIT',
                            ),
                            ScroolCard(
                              select: false,
                              title: 'Calories',
                              ammount: "267",
                              unit: 'Cal',
                            ),
                          ],
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: screenWight,
                        height: 80,
                        color: Colors.black,
                        child: Center(
                          child: Text(
                            '\$48.00',
                            style: kHeading.copyWith(fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: (screenWight / 2) - 100,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('plate1.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScroolCard extends StatelessWidget {
  const ScroolCard({this.select, this.title, this.ammount, this.unit});
  final bool select;
  final String title;
  final String ammount;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Container(
        padding: EdgeInsets.all(15),
        height: 150,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: select ? kSecondaryColor : Colors.transparent,
          border: Border.all(
            style: BorderStyle.solid,
            color: Colors.grey.withOpacity(.5),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '$title'.toUpperCase(),
              style: kNormalText.copyWith(
                  color: select ? Colors.white : Colors.grey),
            ),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: '$ammount\n',
                    style: kHeadingSmall.copyWith(
                        color: select ? Colors.white : Colors.black),
                  ),
                  TextSpan(
                    text: '$unit'.toUpperCase(),
                    style: TextStyle(
                        color: select ? Colors.white : Colors.black,
                        fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TopBar(),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'Healthy', style: kHeading),
                    TextSpan(text: ' Food', style: kHeadingLight),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
            ],
          ),
        ),
        Stack(
          // fit: StackFit.loose,
          children: <Widget>[
            ClipPath(
              clipper: CustomShape(),
              child: Container(
                color: Colors.white,
                width: screenWidth,
                height: screenHeight * 0.695,
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Items(
                  screenHeight: screenHeight,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      BottomButton(
                        buttonIcon: Icon(Icons.search),
                        press: () {},
                      ),
                      BottomButton(
                        buttonIcon: Icon(Icons.search),
                        press: () {},
                      ),
                      RaisedButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        onPressed: () {},
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Checkout',
                          style: kHeadingSmall.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class BottomButton extends StatelessWidget {
  const BottomButton({this.buttonIcon, this.press});

  final Icon buttonIcon;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      // onPressed: press,
      child: buttonIcon,
      padding: EdgeInsets.symmetric(vertical: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path clippedPath = Path();
    double curveDistance = 100;
    clippedPath.moveTo(0.0 + curveDistance, 0.0);
    clippedPath.quadraticBezierTo(0.0, 0.0, 0.0, 0.0 + curveDistance);
    clippedPath.lineTo(0.0, size.height);
    clippedPath.lineTo(size.width, size.height);
    clippedPath.lineTo(size.width, 0.0);
    return clippedPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class Items extends StatelessWidget {
  const Items({
    Key key,
    @required this.screenHeight,
  }) : super(key: key);

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(),
                ),
              );
            },
            child: Iteam(
              screenHeight: screenHeight,
              itemName: "Salmon Bowl",
              itemPrice: 24.00,
              itemPic: "plate1.png",
            ),
          ),
          Iteam(
            screenHeight: screenHeight,
            itemName: "Spring Bowl",
            itemPrice: 22.50,
            itemPic: "plate3.png",
          ),
          Iteam(
            screenHeight: screenHeight,
            itemName: "Avocado Bowl",
            itemPrice: 22.50,
            itemPic: "plate4.png",
          ),
          Iteam(
            screenHeight: screenHeight,
            itemName: "Avocado Bowl",
            itemPrice: 22.50,
            itemPic: "plate4.png",
          ),
          Iteam(
            screenHeight: screenHeight,
            itemName: "Spring Bowl",
            itemPrice: 22.50,
            itemPic: "plate3.png",
          ),
          SizedBox(
            height: 70,
          ),
        ],
      ),
    );
  }
}

class Iteam extends StatelessWidget {
  const Iteam({
    @required this.screenHeight,
    @required this.itemName,
    @required this.itemPrice,
    @required this.itemPic,
  });

  final double screenHeight;
  final String itemName;
  final double itemPrice;
  final String itemPic;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 50,
          backgroundImage: NetworkImage(imageurl + itemPic),
        ),
        Container(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$itemName',
                style: kHeadingSmall,
                maxLines: 1,
              ),
              Text('\$$itemPrice', style: kPriceText),
            ],
          ),
        ),
        Icon(
          Icons.add,
          size: 30,
        )
      ],
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Icon(
          Icons.arrow_back_ios,
          size: 30,
          color: Colors.white,
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.filter_list,
              size: 30,
              color: Colors.white,
            ),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.more_horiz,
              size: 30,
              color: Colors.white,
            ),
          ],
        )
      ],
    );
  }
}
