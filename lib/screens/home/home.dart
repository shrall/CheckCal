import 'package:checkcal/screens/home/add_log.dart';
import 'package:checkcal/screens/wrapper.dart';
import 'package:checkcal/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:checkcal/widgets/calendar_timeline.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:expandable/expandable.dart';
import 'package:page_transition/page_transition.dart';
import 'package:checkcal/screens/home/edit_profile.dart';

Color dark = Color.fromRGBO(13, 7, 20, 1);
Color gray = Color.fromRGBO(44, 40, 50, 1);
Color red = Color.fromRGBO(240, 66, 84, 1);
Color orange = Color.fromRGBO(255, 146, 53, 1);
Color bun = Color.fromRGBO(237, 139, 6, 1);
Color meat = Color.fromRGBO(136, 71, 46, 1);
Color lettuce = Color.fromRGBO(145, 166, 29, 1);
Color ketchup = Color.fromRGBO(210, 37, 1, 1);

class Home extends StatefulWidget {
  final int index;
  Home({this.index});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _authService = AuthService();
  final today = DateTime.now();
  int _selectedItemPosition = 0;
  SnakeShape snakeShape = SnakeShape.circle;
  Color selectedColor = Colors.grey[900];
  DateTime _selectedDate = DateTime.now();
  String uid = FirebaseAuth.instance.currentUser.uid;
  String name = "", imgUrl;
  int limit, indexName;
  DateTime joinedDate;
  int breakfastIntake = 0, lunchIntake = 0, dinnerIntake = 0, snacksIntake = 0;

  Future<void> fetchIntakes() async {
    // ignore: await_only_futures
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection("logbooks")
        .doc((DateFormat('yyyy-MM-dd').format(DateTime.now())))
        .collection("logs")
        .where('time', isEqualTo: "breakfast")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        breakfastIntake += doc['kcal'];
      });
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection("logbooks")
        .doc((DateFormat('yyyy-MM-dd').format(DateTime.now())))
        .collection("logs")
        .where('time', isEqualTo: "lunch")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        lunchIntake += doc['kcal'];
      });
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection("logbooks")
        .doc((DateFormat('yyyy-MM-dd').format(DateTime.now())))
        .collection("logs")
        .where('time', isEqualTo: "dinner")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        dinnerIntake += doc['kcal'];
      });
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection("logbooks")
        .doc((DateFormat('yyyy-MM-dd').format(DateTime.now())))
        .collection("logs")
        .where('time', isEqualTo: "snacks")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        snacksIntake += doc['kcal'];
      });
    });
    setState(() {});
  }

  Future<void> fetchUserData() async {
    print("fetching");
    // ignore: await_only_futures
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .listen((event) {
      imgUrl = event.data()['imgUrl'];
      if (imgUrl == "") {
        imgUrl = null;
      }
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      name = value.data()['name'];
      limit = value.data()['limit'];
      joinedDate = value.data()['joinedDate'].toDate();
      if (name.contains(" ")) {
        indexName = name.indexOf(" ");
      }
    });
    print("fetched");
    setState(() {});
  }

  @override
  void initState() {
    initializeDateFormatting();
    fetchUserData();
    fetchIntakes();
    super.initState();
    if (widget.index != null) {
      _selectedItemPosition = widget.index;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('home built');
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final List<Widget> _children = [
      Column(
        children: <Widget>[
          SizedBox(
            height: height * 0.05,
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: AutoSizeText(
              indexName != null
                  ? "Hi, " + name.substring(0, indexName)
                  : "Hi, " + name,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.grey[50],
                fontFamily: 'Isidora',
                fontSize: 38,
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 20,
                  child: AutoSizeText(
                      "${DateFormat("EE").format(today)}, ${DateFormat("d MMMM").format(today)}",
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.grey[50],
                          fontFamily: 'Isidora',
                          fontSize: 28)),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(
                      "|",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: 'Isidora',
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Text>[
                        Text(
                          "Intake",
                          style: TextStyle(
                              color: Colors.amber[400], fontFamily: 'Isidora'),
                        ),
                        Text(
                          (breakfastIntake +
                                      lunchIntake +
                                      dinnerIntake +
                                      snacksIntake)
                                  .toString() +
                              " kcal",
                          style: TextStyle(
                              color: Colors.grey[100], fontFamily: 'Isidora'),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Text>[
                        Text(
                          "Limit",
                          style: TextStyle(
                              color: Colors.red, fontFamily: 'Isidora'),
                        ),
                        Text(
                          limit.toString() + " kcal",
                          style: TextStyle(
                              color: Colors.grey[100], fontFamily: 'Isidora'),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 560,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50)),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 45,
                  child: Material(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    child: InkWell(
                      onTap: () {
                        print(uid);
                        Navigator.push(
                          context,
                          PageTransition(
                            duration: Duration(milliseconds: 800),
                            child: AddLog(
                              uid: uid,
                              type: "snacks",
                            ),
                            type: PageTransitionType.rightToLeftWithFade,
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 35),
                        width: width - 60,
                        height: 135,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Icon(
                                FontAwesomeIcons.cookieBite,
                                size: 50,
                                color: meat,
                              ),
                            ),
                            SizedBox(width: width * 0.15),
                            Expanded(
                              flex: 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Snacks.',
                                    style: TextStyle(
                                      color: meat,
                                      fontSize: 30,
                                      fontFamily: 'Isidora',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    "$snacksIntake kcal",
                                    style: TextStyle(
                                      color: meat,
                                      fontSize: 20,
                                      fontFamily: 'Isidora',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 160,
                  child: Container(
                    width: width - 60,
                    height: 155,
                    decoration: BoxDecoration(
                      color: dark,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 170,
                  child: Material(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            duration: Duration(milliseconds: 800),
                            child: AddLog(
                              uid: uid,
                              type: "dinner",
                            ),
                            type: PageTransitionType.rightToLeftWithFade,
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 35),
                        width: width - 60,
                        height: 135,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(50)),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Icon(
                                FontAwesomeIcons.utensils,
                                size: 50,
                                color: lettuce,
                              ),
                            ),
                            SizedBox(width: width * 0.15),
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Dinner.',
                                    style: TextStyle(
                                      color: lettuce,
                                      fontSize: 30,
                                      fontFamily: 'Isidora',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    "$dinnerIntake kcal",
                                    style: TextStyle(
                                      color: lettuce,
                                      fontSize: 20,
                                      fontFamily: 'Isidora',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 290,
                  child: Container(
                    width: width - 60,
                    height: 155,
                    decoration: BoxDecoration(
                      color: dark,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(25)),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 300,
                  child: Material(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            duration: Duration(milliseconds: 800),
                            child: AddLog(
                              uid: uid,
                              type: "lunch",
                            ),
                            type: PageTransitionType.rightToLeftWithFade,
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 35),
                        width: width - 60,
                        height: 135,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Icon(
                                FontAwesomeIcons.pizzaSlice,
                                size: 50,
                                color: ketchup,
                              ),
                            ),
                            SizedBox(width: width * 0.15),
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Lunch.',
                                    style: TextStyle(
                                      color: ketchup,
                                      fontSize: 30,
                                      fontFamily: 'Isidora',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    "$lunchIntake kcal",
                                    style: TextStyle(
                                      color: ketchup,
                                      fontSize: 20,
                                      fontFamily: 'Isidora',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 420,
                  child: Container(
                    width: width - 60,
                    height: 155,
                    decoration: BoxDecoration(
                      color: dark,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(25)),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 430,
                  child: Material(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            duration: Duration(milliseconds: 800),
                            child: AddLog(
                              uid: uid,
                              type: "breakfast",
                            ),
                            type: PageTransitionType.rightToLeftWithFade,
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 35),
                        width: width - 60,
                        height: 125,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Icon(
                                FontAwesomeIcons.bacon,
                                size: 50,
                                color: bun,
                              ),
                            ),
                            SizedBox(width: width * 0.15),
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Breakfast.',
                                    style: TextStyle(
                                      color: bun,
                                      fontSize: 30,
                                      fontFamily: 'Isidora',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    "$breakfastIntake kcal",
                                    style: TextStyle(
                                      color: bun,
                                      fontSize: 20,
                                      fontFamily: 'Isidora',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Calorie Logbook',
                style: TextStyle(
                  color: Colors.grey[50],
                  fontSize: 24,
                ),
              ),
            ),
            CalendarTimeline(
              initialDate: _selectedDate,
              firstDate: joinedDate ?? _selectedDate,
              lastDate: DateTime.now().add(Duration(days: 365)),
              onDateSelected: (date) {
                setState(() {
                  _selectedDate = date;
                  print(_selectedDate);
                });
              },
              leftMargin: 20,
              monthColor: Colors.white70,
              dayColor: Colors.grey,
              activeDayColor: Colors.white,
              activeBackgroundDayColor: red,
              dotsColor: Color(0xFF333A47),
              locale: 'en',
            ),
            Divider(
              color: Colors.grey[50],
            ),
            Container(
                margin: EdgeInsets.only(left: 20, top: 10, bottom: 20),
                child: Row(
                  children: [
                    Text(
                      'Calorie Info',
                      style: TextStyle(color: Colors.grey[50], fontSize: 24),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      '|',
                      style: TextStyle(
                        color: Colors.grey[50],
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Text>[
                        Text(
                          "Total Intake",
                          style: TextStyle(
                              color: Colors.amber[400], fontFamily: 'Isidora'),
                        ),
                        Text(
                          "930 kcal",
                          style: TextStyle(
                              color: Colors.grey[100], fontFamily: 'Isidora'),
                        )
                      ],
                    ),
                  ],
                )),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.grey[50],
                          width: 1,
                        ),
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                      child: ExpandablePanel(
                        theme: ExpandableThemeData(iconColor: Colors.grey[50]),
                        header: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.bacon,
                              color: Colors.grey[50],
                              size: 32,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Breakfast - ",
                              style: TextStyle(
                                color: Colors.grey[50],
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              "10 kcal",
                              style: TextStyle(
                                color: Colors.grey[50],
                                fontSize: 24,
                              ),
                            )
                          ],
                        ),
                        expanded: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              color: Colors.grey,
                              endIndent: 30,
                            ),
                            Text(
                              "Egg - 10 kcal",
                              style: TextStyle(
                                color: Colors.grey[50],
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                        collapsed: null,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.grey[50],
                          width: 1,
                        ),
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                      child: ExpandablePanel(
                        theme: ExpandableThemeData(iconColor: Colors.grey[50]),
                        header: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.pizzaSlice,
                              color: Colors.grey[50],
                              size: 32,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Lunch - ",
                              style: TextStyle(
                                color: Colors.grey[50],
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              "410 kcal",
                              style: TextStyle(
                                color: Colors.grey[50],
                                fontSize: 24,
                              ),
                            )
                          ],
                        ),
                        expanded: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              color: Colors.grey,
                              endIndent: 30,
                            ),
                            Text(
                              "Fried Rice - 310 kcal",
                              style: TextStyle(
                                color: Colors.grey[50],
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Milk - 100 kcal",
                              style: TextStyle(
                                color: Colors.grey[50],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        collapsed: null,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.grey[50],
                          width: 1,
                        ),
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                      child: ExpandablePanel(
                        theme: ExpandableThemeData(iconColor: Colors.grey[50]),
                        header: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.utensils,
                              color: Colors.grey[50],
                              size: 32,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Dinner - ",
                              style: TextStyle(
                                color: Colors.grey[50],
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              "210 kcal",
                              style: TextStyle(
                                color: Colors.grey[50],
                                fontSize: 24,
                              ),
                            )
                          ],
                        ),
                        expanded: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              color: Colors.grey,
                              endIndent: 30,
                            ),
                            Text(
                              "Pizza - 210 kcal",
                              style: TextStyle(
                                color: Colors.grey[50],
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                        collapsed: null,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.grey[50],
                          width: 1,
                        ),
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                      child: ExpandablePanel(
                        theme: ExpandableThemeData(iconColor: Colors.grey[50]),
                        header: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.cookieBite,
                              color: Colors.grey[50],
                              size: 32,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Snacks - ",
                              style: TextStyle(
                                color: Colors.grey[50],
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              "300 kcal",
                              style: TextStyle(
                                color: Colors.grey[50],
                                fontSize: 24,
                              ),
                            )
                          ],
                        ),
                        expanded: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              color: Colors.grey,
                              endIndent: 30,
                            ),
                            Text(
                              "Chocolate Chip Cookie - 100 kcal",
                              style: TextStyle(
                                color: Colors.grey[50],
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Oreo - 200 kcal",
                              style: TextStyle(
                                color: Colors.grey[50],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        collapsed: null,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(150),
                ),
                border: Border.all(
                  width: 2,
                  color: Colors.grey[50],
                  style: BorderStyle.solid,
                ),
              ),
              child: imgUrl != null
                  ? ClipOval(
                      child: Image.network(
                        imgUrl,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipOval(
                      child: Container(
                        width: 150,
                        height: 150,
                        child: Icon(
                          FontAwesomeIcons.camera,
                          color: Colors.grey,
                          size: 50,
                        ),
                      ),
                    ),
            ),
            Text(
              name,
              style: TextStyle(
                color: Colors.grey[50],
                fontFamily: 'Isidora',
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's",
                        style: TextStyle(
                          fontFamily: 'Isidora',
                          color: Colors.grey[50],
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Intake",
                        style: TextStyle(
                          fontFamily: 'Isidora',
                          color: Colors.amber,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    '10 Kcal',
                    style: TextStyle(
                        fontFamily: 'Isidora',
                        color: Colors.grey[50],
                        fontSize: 24),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    '|',
                    style: TextStyle(
                      color: Colors.grey[50],
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "User's",
                        style: TextStyle(
                          fontFamily: 'Isidora',
                          color: Colors.grey[50],
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Limit",
                        style: TextStyle(
                          fontFamily: 'Isidora',
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    limit.toString() + " kcal",
                    style: TextStyle(
                        fontFamily: 'Isidora',
                        color: Colors.grey[50],
                        fontSize: 24),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.grey[50],
                      width: 1),
                ),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: EditProfile(
                            uid: uid, name: name, limit: limit, imgUrl: imgUrl),
                        type: PageTransitionType.rightToLeftWithFade,
                      ),
                    );
                  },
                  leading: Icon(
                    FontAwesomeIcons.userEdit,
                    color: Colors.grey[50],
                  ),
                  title: Text(
                    "Change profile.",
                    style: TextStyle(
                      color: Colors.grey[50],
                      fontFamily: 'Isidora',
                    ),
                  ),
                  subtitle: Text(
                    "you can set your daily intake limit here.",
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Isidora',
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.grey[50],
                      width: 1),
                ),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                child: ListTile(
                  onTap: () async {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        duration: Duration(milliseconds: 800),
                        child: Wrapper(
                          index: 0,
                          email: null,
                          password: null,
                        ),
                        type: PageTransitionType.fade,
                      ),
                    );
                    await _authService.signOut();
                  },
                  leading: Icon(
                    FontAwesomeIcons.signOutAlt,
                    color: Colors.grey[50],
                  ),
                  title: Text(
                    "Sign out.",
                    style: TextStyle(
                      color: Colors.grey[50],
                      fontFamily: 'Isidora',
                    ),
                  ),
                  subtitle: Text(
                    "bye.",
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Isidora',
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ];
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: dark,
        bottomNavigationBar: SnakeNavigationBar.color(
          padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
          snakeShape: snakeShape,
          snakeViewColor: Colors.white,
          backgroundColor: dark,
          selectedItemColor: selectedColor,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedItemPosition,
          onTap: (int index) {
            setState(() {
              _selectedItemPosition = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Logbook'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
        body: _children[_selectedItemPosition],
      ),
    );
  }
}
