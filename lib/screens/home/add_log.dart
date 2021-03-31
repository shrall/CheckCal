import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:checkcal/models/log.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:checkcal/widgets/add_dialog.dart';

Color dark = Color.fromRGBO(13, 7, 20, 1);
Color gray = Color.fromRGBO(44, 40, 50, 1);
Color red = Color.fromRGBO(240, 66, 84, 1);
Color orange = Color.fromRGBO(255, 146, 53, 1);

class AddLog extends StatefulWidget {
  final String type;
  AddLog({this.type});
  @override
  _AddLogState createState() => _AddLogState();
}

class _AddLogState extends State<AddLog> {
  var logs = [
    Log("Android Cupcake", 1),
    Log("Android Donut", 2),
    Log("Android Eclair", 1),
    Log("Android Froyo", 2),
    Log("Android Gingerbread", 1),
    Log("Android Honeycomb", 2),
    Log("Android Ice Cream Sandwich", 1),
    Log("Android Jelly Bean", 2),
    Log("Android Kitkat", 1),
    Log("Android Lollipop", 2),
    Log("Android Marshmallow", 1),
    Log("Android Nougat", 2),
    Log("Android Oreo", 1),
    Log("Android Pie", 2),
    Log("Android Pie", 2),
    Log("Android Pie", 2),
    Log("Android Pie", 2)
  ];
  int totalKcal = 0;

  getTotal() {
    totalKcal = 0;
    logs.forEach((log) {
      totalKcal += log.kcal;
    });
    return totalKcal;
  }

  Widget getTitle() {
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
          SizedBox(width: 12),
          Text(
            '|',
            style: TextStyle(
              color: Colors.grey[50],
              fontSize: 32,
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Text>[
              Text(
                "Total Intake",
                style:
                    TextStyle(color: Colors.amber[400], fontFamily: 'Isidora'),
              ),
              Text(
                getTotal().toString() + " kcal",
                style:
                    TextStyle(color: Colors.grey[100], fontFamily: 'Isidora'),
              )
            ],
          ),
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
          SizedBox(width: 12),
          Text(
            '|',
            style: TextStyle(
              color: Colors.grey[50],
              fontSize: 32,
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Text>[
              Text(
                "Total Intake",
                style:
                    TextStyle(color: Colors.amber[400], fontFamily: 'Isidora'),
              ),
              Text(
                getTotal().toString() + " kcal",
                style:
                    TextStyle(color: Colors.grey[100], fontFamily: 'Isidora'),
              )
            ],
          ),
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
          SizedBox(width: 12),
          Text(
            '|',
            style: TextStyle(
              color: Colors.grey[50],
              fontSize: 32,
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Text>[
              Text(
                "Total Intake",
                style:
                    TextStyle(color: Colors.amber[400], fontFamily: 'Isidora'),
              ),
              Text(
                getTotal().toString() + " kcal",
                style:
                    TextStyle(color: Colors.grey[100], fontFamily: 'Isidora'),
              )
            ],
          ),
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
          SizedBox(width: 12),
          Text(
            '|',
            style: TextStyle(
              color: Colors.grey[50],
              fontSize: 32,
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Text>[
              Text(
                "Total Intake",
                style:
                    TextStyle(color: Colors.amber[400], fontFamily: 'Isidora'),
              ),
              Text(
                getTotal().toString() + " kcal",
                style:
                    TextStyle(color: Colors.grey[100], fontFamily: 'Isidora'),
              )
            ],
          ),
        ],
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
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
                child: getTitle(),
              ),
              Divider(
                color: Colors.grey[400],
                thickness: 2,
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.grey,
                    );
                  },
                  itemBuilder: (context, index) {
                    var log = logs[index];
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: Container(
                        color: dark,
                        child: ListTile(
                          leading: Icon(
                            FontAwesomeIcons.mugHot,
                            color: Colors.white,
                            size: 40,
                          ),
                          title: Text(
                            log.name,
                            style: TextStyle(color: Colors.grey[50]),
                          ),
                          subtitle: Text(
                            log.kcal.toString() + " kcal",
                            style: TextStyle(color: Colors.grey[50]),
                          ),
                        ),
                      ),
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'Delete',
                          color: red,
                          icon: Icons.delete,
                          onTap: () => print('Delete'),
                        ),
                      ],
                    );
                  },
                  itemCount: logs.length,
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
                        onSubmitted: (response) {
                          print(
                              'name: ${response.name}, kcal: ${response.kcal}, type: ${response.type}');
                          setState(() {});
                        },
                      ));
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
    );
  }
}
