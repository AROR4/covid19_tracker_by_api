import 'dart:async';

import 'package:covid19_tracker_by_api/View/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math';
class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> with TickerProviderStateMixin{
  late final AnimationController _controller= AnimationController(vsync: this,
  duration: const Duration(seconds: 3))..repeat();
  @override

  void dispose(){
    super.dispose();
    _controller.dispose();
  }
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 3),()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>worldstates())));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(animation: _controller,
                  child: Container(
                    height: MediaQuery.of(context).size.height * .5,
                    width: MediaQuery.of(context).size.width * .5,
                    child: const Center(
                      child: Image(image: AssetImage('images/virus.png'),),
                    ),
                  ),
                  builder: (BuildContext context, Widget? child){
                  return Transform.rotate(
                      angle: _controller.value * 2.0* pi,
                    child: child,

                  );
                  }
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .01,),
              Text("Covid-19 Tracker",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)
            ],
          ),
        ),
      ),
    );
  }
}
