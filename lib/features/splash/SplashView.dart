import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:memz_clone/api/users/UserModel.dart';
import 'package:memz_clone/api/users/UserStore.dart';
import 'package:memz_clone/firebase_options.dart';
import 'package:memz_clone/styles/colors.dart';
import 'package:memz_clone/styles/fonts.dart';

class Splashview extends StatefulWidget {
  const Splashview({super.key});

  @override
  State<Splashview> createState() => _SplashviewState();
}

class _SplashviewState extends State<Splashview> {
  bool navigateNext = false;
  UserModel? user;
  bool _isEmailVerified = false;
  bool isFirebaseInitialized = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    setState(() {
      isFirebaseInitialized = true;
    });
    return firebaseApp;
  }

  @override
  void initState() {
    _initializeFirebase().whenComplete(() {
      if (FirebaseAuth.instance.currentUser?.uid != null) {
        UserStore.getUserById(id: FirebaseAuth.instance.currentUser!.uid).then(
          (value) => user = value,
        );
      }
      _isEmailVerified =
          FirebaseAuth.instance.currentUser?.emailVerified ?? false;

      delayedNavigation();
    });

    super.initState();
  }

  delayedNavigation() {
    // Future.delayed(const Duration(seconds: 2), () {
    //   getAuthNavigation(
    //     context: context,
    //     isEmailVerified: _isEmailVerified,
    //     user: user,
    //   );
    // });
  }

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
