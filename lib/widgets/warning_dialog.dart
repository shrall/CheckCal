import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color dark = Color.fromRGBO(13, 7, 20, 1);
Color gray = Color.fromRGBO(44, 40, 50, 1);
Color red = Color.fromRGBO(240, 66, 84, 1);
Color orange = Color.fromRGBO(255, 146, 53, 1);

class WarningDialog extends StatelessWidget {
  final String title;
  final String message;
  final Widget icon;
  final String submitButton;
  final Function() onSubmitted;
  final Function onCancelled;

  const WarningDialog({
    @required this.title,
    @required this.message,
    @required this.icon,
    @required this.submitButton,
    @required this.onSubmitted,
    this.onCancelled,
  });

  @override
  Widget build(BuildContext context) {
    final _content = Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            color: gray,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 30, 25, 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    child: icon,
                    padding: const EdgeInsets.only(top: 25, bottom: 25),
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    child: Text(
                      submitButton,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      onSubmitted.call();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        if (onCancelled != null) ...[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: IconButton(
              icon: const Icon(FontAwesomeIcons.arrowLeft,
                  size: 24, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
                onCancelled.call();
              },
            ),
          )
        ]
      ],
    );

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      titlePadding: EdgeInsets.zero,
      scrollable: true,
      title: _content,
    );
  }
}
