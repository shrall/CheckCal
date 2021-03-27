import 'package:checkcal/widgets/loading.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:checkcal/services/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:checkcal/screens/authenticate/sign_up.dart';

Color dark = Color.fromRGBO(13, 7, 20, 1);
Color red = Color.fromRGBO(240, 66, 84, 1);
Color orange = Color.fromRGBO(255, 146, 53, 1);

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  bool _isVisible = true;

  String validatePassword(String value) {
    if (value.length < 8)
      return 'Your password must have at least 8 characters.';
    else
      return null;
  }

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    print('sign in built');
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: dark,
              body: ListView(children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                        child: Text(
                          "Sign In.",
                          style: TextStyle(
                            color: Colors.grey[50],
                            fontFamily: 'Isidora',
                            fontSize: 38,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                        child: Text(
                          "Welcome back.",
                          style: TextStyle(
                            color: Colors.grey[50],
                            fontFamily: 'Isidora',
                            fontSize: 32,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(25, 5, 0, 0),
                        child: Text(
                          'E-Mail',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Isidora',
                              fontSize: 22),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                        width: width - 20,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => EmailValidator.validate(value)
                              ? null
                              : "Please enter a valid email.",
                          onChanged: (val) {
                            {
                              setState(() {
                                email = val;
                              });
                            }
                          },
                          cursorWidth: 0,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Isidora',
                          ),
                          decoration: InputDecoration(
                            hintText: 'E-mail',
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
                        padding: EdgeInsets.fromLTRB(25, 20, 0, 0),
                        child: Text(
                          'Password',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Isidora',
                              fontSize: 22),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                        width: width - 20,
                        child: TextFormField(
                          onChanged: (val) {
                            {
                              setState(
                                () {
                                  password = val;
                                },
                              );
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => validatePassword(value),
                          obscureText: _isVisible,
                          cursorWidth: 0,
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Isidora'),
                          decoration: InputDecoration(
                            hintText: 'Password',
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
                            suffixIcon: new GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isVisible = !_isVisible;
                                });
                              },
                              child: Icon(
                                _isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      Container(
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
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  error =
                                      'Please check your email and password.';
                                  Fluttertoast.showToast(msg: error);
                                  loading = false;
                                });
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please check the fields!");
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Container(
                              constraints: BoxConstraints(
                                minWidth: width - 20,
                                minHeight: 56.0,
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                'Sign In',
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
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(20, 35, 0, 0),
                        width: width - 20,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: 'Isidora',
                              color: Colors.grey[50],
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: "Don't have an account?",
                              ),
                              TextSpan(
                                text: " Sign Up.",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                        child: SignUp(),
                                        duration: Duration(milliseconds: 500),
                                        type: PageTransitionType.fade,
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          );
  }
}
