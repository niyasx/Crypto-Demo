import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gweiland_flutter_task/view/homepage.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
     super.initState();
    Future.delayed(const Duration(seconds: 4)).then((value) => 
    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=>const HomePage())));
   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(height: double.infinity,width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Center(child: Lottie.asset("assets/crypto_anime.json"))],
        ),
      ),
    );
  }
}