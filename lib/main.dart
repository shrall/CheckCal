import 'package:checkcal/models/user.dart';
import 'package:checkcal/screens/splash.dart';
import 'package:provider/provider.dart';
import 'package:checkcal/services/auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: SplashScreen(),
      ),
    );
  }
}
