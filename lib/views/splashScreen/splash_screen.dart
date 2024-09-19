import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restuarant_pager_app/controllers/splash_screen/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
      init: SplashScreenController(),
      builder: (context) {
        return Scaffold(
          body: Stack(
            children: [
              const SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Image(
                  image:
                      AssetImage("assets/splashScreenImg/splashScreenBg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                    Colors.transparent,
                    const Color(0xffFC440E).withOpacity(0.2)
                  ]))),
              Align(
                alignment: const Alignment(-1, 0.8),
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: RichText(
                      text: const TextSpan(
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                          ),
                          children: <TextSpan>[
                        TextSpan(text: "Food is on the \n"),
                        TextSpan(
                            text: "way. Enjoy your \n",
                            style: TextStyle(color: Color(0xffFFC7A9))),
                        TextSpan(text: "meal!")
                      ])),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}