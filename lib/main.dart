import 'package:checkcal/models/user.dart';
import 'package:checkcal/screens/splash.dart';
import 'package:provider/provider.dart';
import 'package:checkcal/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  GlobalKey<NavigatorState> _mainNavigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        navigatorKey: _mainNavigatorKey,
        theme: ThemeData(
          fontFamily: 'Isidora',
        ),
        home: SplashScreen(),
      ),
    );
  }
}
