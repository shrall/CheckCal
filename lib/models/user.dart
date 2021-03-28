import 'package:checkcal/models/logbook.dart';

class MyUser {
  final String uid;

  MyUser({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final int limitkcal;
  final List<Logbook> logbooks;

  UserData({this.uid, this.name, this.limitkcal, this.logbooks});
}
