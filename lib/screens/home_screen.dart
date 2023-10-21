import 'dart:ui';
import 'package:airqualityapp/data/data.dart';
import 'package:airqualityapp/painter.dart';
import 'package:airqualityapp/utils/utils.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final AirQuality airQuality;

  const HomeScreen({
    required this.airQuality,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;

    return Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Air Quality Indicator',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SizedBox(
          height: deviceSize.height,
          child: Stack(
            children: [
              Container(
                height: deviceSize.height,
                width: deviceSize.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/background.png'),
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: kToolbarHeight * 3),
                child: SizedBox(
                  height: deviceSize.height,
                  width: deviceSize.width,
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Stack(
                      children: [
                        CustomPaint(
                          size: Size(
                            deviceSize.width,
                            deviceSize.width,
                          ),
                          painter: AirQualityPainter(aqi: airQuality.aqi),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            height: deviceSize.height * 0.5,
                            width: 400,
                            child: Column(
                              children: [
                                Container(
                                  height: deviceSize.height * 0.25,
                                  width: 400,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        '${airQuality.emoji}',
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: deviceSize.height * 0.15,
                                  width: 400,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white70,
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        airQuality.message!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          height: 1.5,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
