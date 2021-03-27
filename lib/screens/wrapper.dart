import 'package:flutter/material.dart';
import 'package:checkcal/screens/home/home.dart';
import 'package:checkcal/screens/authenticate/authenticate.dart';
import 'package:checkcal/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('wrapper built');
    final user = Provider.of<User>(context);
    print(user.toString() + "asd");
    // return either the Home or Authenticate widget
    if (user == null) {
      print('goauth');
      return Authenticate();
    } else {
      print('gohome');
      return Home();
    }
  }
}
