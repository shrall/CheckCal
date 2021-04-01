import 'package:checkcal/screens/wrapper.dart';
import 'package:checkcal/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:checkcal/widgets/add_dialog.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

Color dark = Color.fromRGBO(13, 7, 20, 1);
Color gray = Color.fromRGBO(44, 40, 50, 1);
Color red = Color.fromRGBO(240, 66, 84, 1);
Color orange = Color.fromRGBO(255, 146, 53, 1);

class AddLog extends StatefulWidget {
  final String type;
  final String uid;
  AddLog({@required this.type, @required this.uid});
  @override
  _AddLogState createState() => _AddLogState();
}

class _AddLogState extends State<AddLog> {
  int totalKcal = 0;

  void fetchTotalKcal() async {
    print("fetching");
    // ignore: await_only_futures
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .collection("logbooks")
        .doc((DateFormat('yyyy-MM-dd').format(DateTime.now())))
        .collection("logs")
        .where('time', isEqualTo: widget.type)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        totalKcal += doc['kcal'];
        print(totalKcal);
      });
    });
    print("fetched" + totalKcal.toString());
    setState(() {});
  }

  Widget getTitle(int total) {
    if (widget.type == 'breakfast') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.bacon,
            color: Colors.white,
            size: 32,
          ),
          SizedBox(width: 12),
          Text(
            'Breakfast',
            style: TextStyle(
              color: Colors.grey[50],
              fontSize: 32,
            ),
          ),
          // SizedBox(width: 12),
          // Text(
          //   '|',
          //   style: TextStyle(
          //     color: Colors.grey[50],
          //     fontSize: 32,
          //   ),
          // ),
          // SizedBox(width: 12),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: <Text>[
          //     Text(
          //       "Total Intake",
          //       style:
          //           TextStyle(color: Colors.amber[400], fontFamily: 'Isidora'),
          //     ),
          //     Text(
          //       total.toString() + " kcal",
          //       style:
          //           TextStyle(color: Colors.grey[100], fontFamily: 'Isidora'),
          //     )
          //   ],
          // ),
        ],
      );
    } else if (widget.type == 'lunch') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.pizzaSlice,
            color: Colors.white,
            size: 32,
          ),
          SizedBox(width: 12),
          Text(
            'Lunch',
            style: TextStyle(
              color: Colors.grey[50],
              fontSize: 32,
            ),
          ),
          // SizedBox(width: 12),
          // Text(
          //   '|',
          //   style: TextStyle(
          //     color: Colors.grey[50],
          //     fontSize: 32,
          //   ),
          // ),
          // SizedBox(width: 12),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: <Text>[
          //     Text(
          //       "Total Intake",
          //       style:
          //           TextStyle(color: Colors.amber[400], fontFamily: 'Isidora'),
          //     ),
          //     Text(
          //       total.toString() + " kcal",
          //       style:
          //           TextStyle(color: Colors.grey[100], fontFamily: 'Isidora'),
          //     )
          //   ],
          // ),
        ],
      );
    } else if (widget.type == 'dinner') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.utensils,
            color: Colors.white,
            size: 32,
          ),
          SizedBox(width: 12),
          Text(
            'Dinner',
            style: TextStyle(
              color: Colors.grey[50],
              fontSize: 32,
            ),
          ),
          // SizedBox(width: 12),
          // Text(
          //   '|',
          //   style: TextStyle(
          //     color: Colors.grey[50],
          //     fontSize: 32,
          //   ),
          // ),
          // SizedBox(width: 12),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: <Text>[
          //     Text(
          //       "Total Intake",
          //       style:
          //           TextStyle(color: Colors.amber[400], fontFamily: 'Isidora'),
          //     ),
          //     Text(
          //       total.toString() + " kcal",
          //       style:
          //           TextStyle(color: Colors.grey[100], fontFamily: 'Isidora'),
          //     )
          //   ],
          // ),
        ],
      );
    } else if (widget.type == 'lunch') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.cookieBite,
            color: Colors.white,
            size: 32,
          ),
          SizedBox(width: 12),
          Text(
            'Snacks',
            style: TextStyle(
              color: Colors.grey[50],
              fontSize: 32,
            ),
          ),
          // SizedBox(width: 12),
          // Text(
          //   '|',
          //   style: TextStyle(
          //     color: Colors.grey[50],
          //     fontSize: 32,
          //   ),
          // ),
          // SizedBox(width: 12),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: <Text>[
          //     Text(
          //       "Total Intake",
          //       style:
          //           TextStyle(color: Colors.amber[400], fontFamily: 'Isidora'),
          //     ),
          //     Text(
          //       total.toString() + " kcal",
          //       style:
          //           TextStyle(color: Colors.grey[100], fontFamily: 'Isidora'),
          //     )
          //   ],
          // ),
        ],
      );
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    // fetchTotalKcal();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
          context,
          PageTransition(
              duration: Duration(milliseconds: 800),
              child: Wrapper(
                index: 0,
              ),
              type: PageTransitionType.leftToRightWithFade),
        );
        return new Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: dark,
          body: Container(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: getTitle(totalKcal),
                ),
                Divider(
                  color: Colors.grey[400],
                  thickness: 2,
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.uid)
                        .collection("logbooks")
                        .doc((DateFormat('yyyy-MM-dd').format(DateTime.now())))
                        .collection("logs")
                        .where('time', isEqualTo: widget.type)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                          height: 200.0,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black45),
                          ),
                        );
                      } else {
                        return ListView.separated(
                          itemBuilder: (_, index) {
                            DocumentSnapshot log = snapshot.data.docs[index];
                            return Slidable(
                              actionPane: SlidableDrawerActionPane(),
                              actionExtentRatio: 0.25,
                              child: Container(
                                color: dark,
                                child: ListTile(
                                  leading: log.data()['type'] != "food"
                                      ? Icon(
                                          FontAwesomeIcons.mugHot,
                                          color: Colors.white,
                                          size: 40,
                                        )
                                      : Icon(
                                          FontAwesomeIcons.hamburger,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                  title: Text(
                                    log.data()['name'],
                                    style: TextStyle(color: Colors.grey[50]),
                                  ),
                                  subtitle: Text(
                                    log.data()['kcal'].toString() + " kcal",
                                    style: TextStyle(color: Colors.grey[50]),
                                  ),
                                ),
                              ),
                              secondaryActions: <Widget>[
                                IconSlideAction(
                                  caption: 'Delete',
                                  color: red,
                                  icon: Icons.delete,
                                  onTap: () async {
                                    await DatabaseService(uid: widget.uid)
                                        .deleteLog(log.id, DateTime.now());
                                    setState(() {});
                                  },
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: Colors.grey,
                            );
                          },
                          itemCount: snapshot.data.docs.length,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton.extended(
              heroTag: 'addButton',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AddDialog(
                    title: 'Add new log.',
                    submitButton: 'Submit',
                    onCancelled: () => print('cancelled'),
                    onSubmitted: (response) async {
                      await DatabaseService(uid: widget.uid).addLog(
                          response.name,
                          response.kcal,
                          widget.type,
                          response.type,
                          DateTime.now());
                      setState(() {});
                    },
                  ),
                );
              },
              label: Text("Add Log.",
                  style: TextStyle(
                      color: Colors.grey[50], fontWeight: FontWeight.bold)),
              icon: Icon(FontAwesomeIcons.plus),
              backgroundColor: gray,
              foregroundColor: Colors.grey[50],
            ),
          ),
        ),
      ),
    );
  }
}
