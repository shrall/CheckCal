import 'package:checkcal/models/logbook.dart';

class User {
  final String uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final int limitkcal;
  final List<Logbook> logbooks;

  UserData({this.uid, this.name, this.limitkcal, this.logbooks});
}
