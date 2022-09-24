import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marvelapp/screens/home_screen.dart';
import '../constants/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin  {
  void navigateToMain(BuildContext context) async {
    final navigator = Navigator.of(context);

    await Future.delayed(const Duration(seconds: 5)).whenComplete(() =>
        navigator.pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen())));
  }

  late final _slideAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  );
  late final Animation<Offset> _slideAnimation =
  Tween<Offset>(begin: const Offset(0, -4), end: const Offset(0, 0))
      .animate(
    CurvedAnimation(
      parent: _slideAnimationController,
      curve: Curves.elasticInOut,
    ),
  );
  late final _fadeAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  );
  late final Animation<double> _fadeAnimation = CurvedAnimation(
    parent: _fadeAnimationController,
    curve: Curves.easeInOut,
  );
  late final _scaleAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
    reverseDuration: const Duration(milliseconds: 444),
  );
  late final Animation<double> _scaleAnimation =
  Tween<double>(begin: 0.4, end: 4).animate(
    CurvedAnimation(
      parent: _scaleAnimationController,
      curve: Curves.elasticInOut,
    ),
  );

  @override
  void initState() {
    super.initState();
    _slideAnimationController.forward();
    _fadeAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 1721)).then((value) {
      _fadeAnimationController.reverse();
      _scaleAnimationController.forward();
    });
  }
  @override
  void dispose() {
    _slideAnimationController.dispose();
    _fadeAnimationController.dispose();
    _scaleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    navigateToMain(context);
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('images/marvel_back.jpg'),
            fit: BoxFit.cover
        ),
      ),
      child:  Scaffold(
        appBar: AppBar(
          shape:  const RoundedRectangleBorder(
            borderRadius:  BorderRadius.only(
                bottomLeft:  Radius.circular(20), bottomRight: Radius.circular(20)
            ),
          ),
          systemOverlayStyle:  const SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarDividerColor: Colors.transparent,
            statusBarColor: myWhite,
          ),
          backgroundColor: myWhite,
          elevation: 8,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/marvel_studios.png' , width: 300, height: 40 , fit: BoxFit.contain,),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Hero(
                  tag: "splash",
                  child: Image.asset('images/marvel-logo.png'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
