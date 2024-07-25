import 'package:flutter/material.dart';
import 'package:memz_clone/styles/colors.dart';
import 'package:memz_clone/styles/fonts.dart';

class Splashview extends StatefulWidget {
  const Splashview({super.key});

  @override
  State<Splashview> createState() => _SplashviewState();
}

class _SplashviewState extends State<Splashview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.background,
      body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Image.asset(
                'assets/SMYL_logo.png',
                height: 160,
              ),
            ),
            Text(
              'send me your location',
              style: Branding.H22.copyWith(color: MColors.grayV3),
            ),
          ],
        ),
      ]),
    );
  }
}
