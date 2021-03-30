import 'package:checkcal/screens/authenticate/intro.dart';
import 'package:checkcal/screens/authenticate/sign_in.dart';
import 'package:checkcal/screens/authenticate/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:checkcal/screens/home/home.dart';
import 'package:checkcal/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  final int index;
  final String email;
  final String password;
  Wrapper({this.index, this.email, this.password});

  int signOut = 0;

  @override
  Widget build(BuildContext context) {
    print('wrapper built');
    final user = Provider.of<MyUser>(context);
    print(user.toString() + "asd");

    // return either the Home or Authenticate widget
    if (user == null) {
      print('goauth');
      if (index == 1 || signOut != 0) {
        return SignIn();
      } else if (index == 2) {
        return SignUp();
      } else if (index == 3) {
        return Intro(
          email: email,
          password: password,
        );
      }
    } else {
      print('gohome');
      signOut += 1;
      return Home();
    }
  }
}
