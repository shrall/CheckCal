import 'package:checkcal/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:checkcal/widgets/loading.dart';

Color dark = Color.fromRGBO(13, 7, 20, 1);
Color gray = Color.fromRGBO(44, 40, 50, 1);
Color red = Color.fromRGBO(240, 66, 84, 1);
Color orange = Color.fromRGBO(255, 146, 53, 1);

class Intro extends StatefulWidget {
  final String email;
  final String password;
  Intro({this.email, this.password});

  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> with SingleTickerProviderStateMixin {
  AnimationController _gradientController;
  Animation _animation;
  String name = "";
  int limit = 0;
  String email = "";
  String password = "";

  final AuthService _auth = AuthService();
  final _introKey = GlobalKey<IntroductionScreenState>();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void initState() {
    super.initState();

    _gradientController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _gradientController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _gradientController.reverse();
        _gradientController.repeat(reverse: true);
      }
    });

    _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _gradientController, curve: Curves.ease));

    _animation.addListener(() {
      setState(() {});
    });

    _gradientController.forward();
  }

  @override
  void dispose() {
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    email = widget.email;
    password = widget.password;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Color.fromRGBO(13, 7, 20, 1),
      imagePadding: EdgeInsets.zero,
    );
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

    return loading
        ? Loading()
        : Form(
            key: _formKey,
            child: IntroductionScreen(
              key: _introKey,
              color: Colors.grey[50],
              nextColor: Colors.grey[50],
              globalBackgroundColor: dark,
              pages: [
                PageViewModel(
                  titleWidget: Container(
                    width: width - 20,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
                    child: ShaderMask(
                      child: Text(
                        "ChecKcal",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 62,
                            fontFamily: 'Isidora',
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      shaderCallback: (rect) {
                        return LinearGradient(stops: [
                          _animation.value - 0.5,
                          _animation.value + 0.8
                        ], colors: [
                          red,
                          orange
                        ]).createShader(rect);
                      },
                    ),
                  ),
                  bodyWidget: Container(
                    width: width - 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to ChecKcal.',
                          style: TextStyle(
                            color: Colors.grey[50],
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "ChecKcal is an app to keep track of your daily calorie intake.",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "It is very recommended for you to use this app if you are on a calorie deficit diet.",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Okay. Let's complete your registration so you can get started.",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  titleWidget: Container(),
                  bodyWidget: Container(
                    height: height * 0.85,
                    padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "What's your name?",
                          style: TextStyle(
                            color: Colors.grey[50],
                            fontSize: 16,
                          ),
                        ),
                        TextFormField(
                          initialValue: name,
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
                      ],
                    ),
                  ),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  titleWidget: Container(),
                  bodyWidget: Container(
                    height: height * 0.85,
                    padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Set your daily intake.",
                          style: TextStyle(
                            color: Colors.grey[50],
                            fontSize: 16,
                          ),
                        ),
                        TextFormField(
                          initialValue: limit != 0 ? limit.toString() : "",
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
                      ],
                    ),
                  ),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  titleWidget: Container(
                    width: width - 20,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
                    child: Text(
                      "ChecKcal",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 62,
                          fontFamily: 'Isidora',
                          fontWeight: FontWeight.bold,
                          color: Colors.transparent),
                    ),
                  ),
                  bodyWidget: Container(
                    width: width - 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Okay. You're all set.",
                          style: TextStyle(
                            color: Colors.grey[50],
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Remember.",
                          style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Generally, the recommended daily calorie intake is 2,000 calories a day for women and 2,500 for men.",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "[nhs.uk, 2019]",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: pageDecoration,
                ),
              ],
              onDone: () async {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    loading = true;
                    print('loading set to true');
                  });
                  dynamic result = await _auth.registerWithEmailAndPassword(
                    email,
                    password,
                    name,
                    limit,
                  );
                  if (result == null) {
                    setState(() {
                      Fluttertoast.showToast(
                          msg: 'Your email is already registered.');
                      loading = false;
                      print('loading set to false');
                    });
                  }
                } else {
                  Fluttertoast.showToast(msg: "Please check all the fields!");
                }
              },
              showSkipButton: false,
              skipFlex: 0,
              nextFlex: 0,
              next: const Icon(Icons.arrow_forward),
              done: const Text('Done',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              dotsDecorator: DotsDecorator(
                size: const Size.square(10.0),
                activeSize: const Size(20.0, 10.0),
                activeColor: Colors.grey[50],
                color: Colors.grey[700],
                spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          );
  }
}
