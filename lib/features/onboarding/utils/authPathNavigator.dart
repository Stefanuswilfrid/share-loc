import 'package:flutter/material.dart';
import 'package:memz_clone/features/mainViews/MainViews.dart';
import 'package:memz_clone/features/onboarding/PickEmojiView.dart';
import 'package:memz_clone/features/onboarding/PickUsernameView.dart';
import 'package:memz_clone/features/onboarding/VerifyEmail.dart';
import 'package:memz_clone/screens/authentication/email_password/sign_in_screen.dart';

import '../../../api/users/UserModel.dart';

getAuthNavigation({
  required BuildContext context,
  UserModel? user,
  bool? isEmailVerified,
}) {
  print("signin ${user} ${isEmailVerified}");
  if (user != null) {
    if (isEmailVerified != true) {
      print('email not verified');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => VerifyEmailView(),
      ));
      return;
    } else if (user.username == null) {
      print('no username');

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => PickUsernameView(),
      ));
      return;
    } else if (user.emoji == null) {
      print('no username');

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Pickemojiview(),
      ));
      return;
    } else {
      print('normal user sign in');

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MainViews(),
      ));
      return;
    }
  } else {
    print('user is null');

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => SignInScreen(),
    ));
    return;
  }
}
