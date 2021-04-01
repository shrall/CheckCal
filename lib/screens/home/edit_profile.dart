import 'dart:io';
import 'package:checkcal/screens/wrapper.dart';
import 'package:checkcal/services/database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

Color dark = Color.fromRGBO(13, 7, 20, 1);
Color gray = Color.fromRGBO(44, 40, 50, 1);
Color red = Color.fromRGBO(240, 66, 84, 1);
Color orange = Color.fromRGBO(255, 146, 53, 1);

class EditProfile extends StatefulWidget {
  final String uid;
  final String name;
  final int limit;
  final String imgUrl;
  EditProfile({this.uid, this.name, this.limit, this.imgUrl});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File _image;
  String name;
  int limit;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  Future _getGallery() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 100);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _getCamera() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 100);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              color: gray,
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading:
                          new Icon(Icons.photo_library, color: Colors.grey[50]),
                      title: new Text('Gallery',
                          style: TextStyle(color: Colors.grey[50])),
                      onTap: () {
                        _getGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading:
                        new Icon(Icons.photo_camera, color: Colors.grey[50]),
                    title: new Text('Camera',
                        style: TextStyle(color: Colors.grey[50])),
                    onTap: () {
                      _getCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  String validateName(String value) {
    if (value.length < 1)
      return 'Your name cannot be empty!';
    else
      return null;
  }

  String validateLimit(String value) {
    if (value != null) {
      if (value.length < 1 || int.parse(value) == 0)
        return 'Your intake limit cannot be less than 0!';
      else if (value.length > 4)
        return 'Your intake limit cannot be more than 9999!';
      else
        return null;
    } else
      return 'Your intake limit cannot be less than 0!';
  }

  getTempImage() {
    if (_image != null) {
      return ClipOval(
        child: Image.file(
          _image,
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        ),
      );
    } else if (widget.imgUrl != "" && widget.imgUrl != null) {
      return ClipOval(
        child: Image.network(
          widget.imgUrl,
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return ClipOval(
        child: Container(
          width: 150,
          height: 150,
          child: Icon(
            FontAwesomeIcons.camera,
            color: Colors.grey,
            size: 50,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: dark,
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _showPicker(context);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(150),
                      ),
                      border: Border.all(
                        width: 2,
                        color: Colors.grey[50],
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: getTempImage(),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                width: width - 20,
                child: TextFormField(
                  initialValue: widget.name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => validateName(value),
                  onChanged: (val) {
                    {
                      setState(() {
                        name = val;
                      });
                    }
                  },
                  cursorWidth: 0,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Isidora',
                  ),
                  decoration: InputDecoration(
                    hintText: 'Your name.',
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
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                width: width - 20,
                child: TextFormField(
                  initialValue: widget.limit.toString(),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => validateLimit(value),
                  onChanged: (val) {
                    {
                      setState(() {
                        limit = int.tryParse(val);
                      });
                    }
                  },
                  cursorWidth: 0,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Isidora',
                  ),
                  decoration: InputDecoration(
                    hintText: '> 0 kcal.',
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
              Expanded(
                  child: Center(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                  width: width - 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        if (name == null) {
                          name = widget.name;
                        }
                        if (limit == null) {
                          limit = widget.limit;
                        }
                        await DatabaseService().updateProfile(
                          widget.uid,
                          name,
                          limit,
                        );
                        if (_image != null) {
                          await DatabaseService()
                              .updateProfilePic(widget.uid, _image);
                        }
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                              duration: Duration(milliseconds: 800),
                              child: Wrapper(
                                index: 2,
                              ),
                              type: PageTransitionType.leftToRightWithFade),
                        );
                      } else {
                        Fluttertoast.showToast(msg: "Please check the fields!");
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.all(0.0),
                      ),
                    ),
                    child: Ink(
                      width: width - 20,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: <Color>[red, orange],
                          stops: [0.3, 0.9],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Container(
                        constraints: BoxConstraints(
                          minWidth: width - 20,
                          minHeight: 56.0,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Save Profile',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Isidora',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
