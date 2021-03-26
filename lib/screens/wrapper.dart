import 'package:flutter/material.dart';
import 'package:checkcal/screens/home/home.dart';
import 'package:checkcal/screens/authenticate/authenticate.dart';
import 'package:checkcal/models/user.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
