import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Color dark = Color.fromRGBO(13, 7, 20, 1);
Color gray = Color.fromRGBO(44, 40, 50, 1);
Color red = Color.fromRGBO(240, 66, 84, 1);
Color orange = Color.fromRGBO(255, 146, 53, 1);

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('loading built');
    return Container(
      color: dark,
      child: Center(
        child: SpinKitRipple(
          color: Colors.grey[100],
          size: 500.0,
        ),
      ),
    );
  }
}
