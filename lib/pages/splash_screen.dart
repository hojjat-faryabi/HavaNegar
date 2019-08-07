import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  AnimationController animController ;
  Animation<double> anim;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animController = new AnimationController(vsync: this, duration: Duration(seconds: 3));
    anim = Tween(begin: 0.0, end: 3.14).animate(CurvedAnimation(
        parent: animController,
        curve:  Curves.linear,
      )
    );
    animController.addListener((){
      if(animController.isCompleted){
        animController.repeat();
      }
    });

  }


  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;
    animController.forward();

    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white,Colors.yellow[600]],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          ),
        ),
        child: AnimatedBuilder(
            animation: anim,
            builder: (c, ch){
              return Transform.rotate(
                  angle: anim.value,
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/images/splash_image.svg",
                      width: screenSize.width*.65,
                    ),
                  ),
              );
            }
        )
      ),
    );
  }

}