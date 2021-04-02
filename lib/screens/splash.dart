import 'package:checkcal/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:checkcal/widgets/splash_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:provider/provider.dart';

Color dark = Color.fromRGBO(13, 7, 20, 1);
Color gray = Color.fromRGBO(44, 40, 50, 1);
Color red = Color.fromRGBO(240, 66, 84, 1);
Color orange = Color.fromRGBO(255, 146, 53, 1);
Color bun = Color.fromRGBO(237, 139, 6, 1);
Color meat = Color.fromRGBO(136, 71, 46, 1);
Color lettuce = Color.fromRGBO(145, 166, 29, 1);
Color ketchup = Color.fromRGBO(210, 37, 1, 1);

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _rotationController;
  AnimationController _gradientController;
  Animation _animation;
  void splashToHome() {
    Future.delayed(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          PageTransition(
            duration: Duration(milliseconds: 1000),
            child: Wrapper(index: 0, email: null, password: null),
            type: PageTransitionType.fade,
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    )..repeat();
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
    splashToHome();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('splash built');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: dark,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SplashIcon(
              animationController: _rotationController,
              top: 30,
              left: 20,
              angle: 0,
              icon: FontAwesomeIcons.hamburger,
              color: gray,
              size: 32,
            ),
            SplashIcon(
              animationController: _rotationController,
              top: 170,
              left: 60,
              angle: 70,
              icon: FontAwesomeIcons.hotdog,
              color: gray,
              size: 36,
            ),
            SplashIcon(
              animationController: _rotationController,
              top: 75,
              left: 140,
              angle: 50,
              icon: FontAwesomeIcons.bacon,
              color: gray,
              size: 36,
            ),
            SplashIcon(
              animationController: _rotationController,
              top: 145,
              left: 240,
              angle: 20,
              icon: FontAwesomeIcons.drumstickBite,
              color: gray,
              size: 36,
            ),
            SplashIcon(
              animationController: _rotationController,
              top: 40,
              left: 300,
              angle: 120,
              icon: FontAwesomeIcons.pizzaSlice,
              color: gray,
              size: 36,
            ),
            SplashIcon(
              animationController: _rotationController,
              top: 210,
              right: 30,
              angle: 120,
              icon: FontAwesomeIcons.stroopwafel,
              color: gray,
              size: 36,
            ),
            SplashIcon(
              animationController: _rotationController,
              top: 280,
              left: 25,
              angle: 220,
              icon: FontAwesomeIcons.breadSlice,
              color: gray,
              size: 36,
            ),
            SplashIcon(
              animationController: _rotationController,
              top: 280,
              left: 250,
              angle: 220,
              icon: FontAwesomeIcons.carrot,
              color: gray,
              size: 36,
            ),
            SplashIcon(
              animationController: _rotationController,
              bottom: 270,
              left: 85,
              angle: 220,
              icon: FontAwesomeIcons.cookieBite,
              color: gray,
              size: 36,
            ),
            SplashIcon(
              animationController: _rotationController,
              bottom: 200,
              left: 215,
              angle: 240,
              icon: FontAwesomeIcons.cheese,
              color: gray,
              size: 36,
            ),
            SplashIcon(
              animationController: _rotationController,
              bottom: 234,
              right: 15,
              angle: 240,
              icon: FontAwesomeIcons.candyCane,
              color: gray,
              size: 36,
            ),
            SplashIcon(
              animationController: _rotationController,
              bottom: 150,
              left: 15,
              angle: 140,
              icon: FontAwesomeIcons.fish,
              color: gray,
              size: 36,
            ),
            SplashIcon(
              animationController: _rotationController,
              bottom: 90,
              left: 135,
              angle: 240,
              icon: FontAwesomeIcons.iceCream,
              color: gray,
              size: 36,
            ),
            SplashIcon(
              animationController: _rotationController,
              bottom: 20,
              left: 45,
              angle: 240,
              icon: FontAwesomeIcons.pepperHot,
              color: gray,
              size: 36,
            ),
            SplashIcon(
              animationController: _rotationController,
              bottom: 115,
              right: 60,
              angle: 240,
              icon: FontAwesomeIcons.solidLemon,
              color: gray,
              size: 36,
            ),
            SplashIcon(
              animationController: _rotationController,
              bottom: 10,
              right: 135,
              angle: 240,
              icon: FontAwesomeIcons.egg,
              color: gray,
              size: 36,
            ),
            Center(
              child: Container(
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
                    return LinearGradient(
                        stops: [_animation.value - 0.5, _animation.value + 0.8],
                        colors: [red, orange]).createShader(rect);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
