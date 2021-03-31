import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

Color dark = Color.fromRGBO(13, 7, 20, 1);
Color gray = Color.fromRGBO(44, 40, 50, 1);
Color red = Color.fromRGBO(240, 66, 84, 1);
Color orange = Color.fromRGBO(255, 146, 53, 1);

class AddDialog extends StatelessWidget {
  final String title;
  final String submitButton;
  final Function(AddDialogResponse) onSubmitted;

  final Function onCancelled;

  AddDialog({
    @required this.title,
    @required this.submitButton,
    @required this.onSubmitted,
    this.onCancelled,
  });
  String validateName(String value) {
    if (value.length < 1)
      return 'The item name cannot be empty.';
    else
      return null;
  }

  String validatekcal(String value) {
    if (value.length < 1)
      return "The item's calorie cannot be empty.";
    else
      return null;
  }

  final _nameController = TextEditingController();
  final _kcalController = TextEditingController();
  final _response = AddDialogResponse();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final _content = Stack(
      alignment: Alignment.topLeft,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            color: gray,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Form(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            width: width,
                            child: TextFormField(
                              controller: _nameController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) => validateName(value),
                              cursorWidth: 0,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Isidora',
                              ),
                              decoration: InputDecoration(
                                hintText: 'Name',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Isidora',
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: red,
                                    width: 2,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: red,
                                    width: 2.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey[100],
                                    width: 2.5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey[400],
                                    width: 2,
                                  ),
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Isidora',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            width: width,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              controller: _kcalController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) => validatekcal(value),
                              cursorWidth: 0,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Isidora',
                              ),
                              decoration: InputDecoration(
                                hintText: '0 kcal',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Isidora',
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: red,
                                    width: 2,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: red,
                                    width: 2.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey[100],
                                    width: 2.5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey[400],
                                    width: 2,
                                  ),
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Isidora',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: width,
                            height: 50,
                            child: CustomRadioButton(
                              width: 130,
                              elevation: 0,
                              enableButtonWrap: true,
                              enableShape: true,
                              customShape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              unSelectedBorderColor: dark,
                              selectedBorderColor: Colors.white,
                              unSelectedColor: Colors.grey[50],
                              selectedColor: orange,
                              buttonLables: [
                                'Food',
                                'Beverage',
                              ],
                              buttonValues: [
                                "food",
                                "beverage",
                              ],
                              defaultSelected: "food",
                              buttonTextStyle: ButtonTextStyle(
                                selectedColor: Colors.white,
                                unSelectedColor: Colors.black,
                                textStyle: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              radioButtonValue: (value) {
                                _response.type = value;
                              },
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 12,
                  ),
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
                      if (_nameController.text.length < 1 ||
                          _kcalController.text.length < 1) {
                        Fluttertoast.showToast(
                            msg: "Please check all the fields!");
                      } else {
                        Navigator.pop(context);
                        _response.name = _nameController.text;
                        _response.kcal = int.tryParse(_kcalController.text);
                        onSubmitted.call(_response);
                      }
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

class AddDialogResponse {
  String name = '';
  int kcal = 0;
  String type = "food";
}
