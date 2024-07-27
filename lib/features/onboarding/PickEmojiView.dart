import 'package:flutter/material.dart';
import 'package:memz_clone/api/users/UserModel.dart';
import 'package:memz_clone/api/users/UserStore.dart';
import 'package:memz_clone/components/emojiPicker/EmojiPickerView.dart';
import 'package:memz_clone/features/onboarding/OnboardingSuccess.dart';
import 'package:memz_clone/styles/colors.dart';

class Pickemojiview extends StatefulWidget {
  const Pickemojiview({super.key});

  @override
  State<Pickemojiview> createState() => _PickemojiviewState();
}

class _PickemojiviewState extends State<Pickemojiview> {
  UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.background,
      body: EmojiPickerView(onSelect: (emoji) {
        UserStore.updateUser(
          user: user!,
          newEmoji: emoji.toString(),
        ).whenComplete(
          () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => Onboardingsuccess(),
            ),
          ),
        );
      }),
    );
  }
}
