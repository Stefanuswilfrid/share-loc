import 'package:flutter/material.dart';
import 'package:memz_clone/styles/colors.dart';
import 'package:memz_clone/styles/fonts.dart';

class VerifyEmailView extends StatefulWidget {
  @override
  VerifyEmailViewState createState() => VerifyEmailViewState();
}

class VerifyEmailViewState extends State<VerifyEmailView> {
  bool _verificationEmailBeingSent = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.background,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Image.asset(
                  'assets/SMYL_logo.png',
                  height: 60,
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Please verify your email to get started',
                      style: Heading.H26,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {},
                      child: Text('I verified my email',
                          style:
                              SubHeading.SH18.copyWith(color: MColors.black)),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                        backgroundColor: MColors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _verificationEmailBeingSent
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              MColors.grayV3,
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              setState(() {
                                _verificationEmailBeingSent = true;
                              });
                              setState(() {
                                _verificationEmailBeingSent = false;
                              });
                            },
                            child: Text(
                                'Didn\'t get an email?\nResend verification email',
                                style: SubHeading.SH14
                                    .copyWith(color: MColors.grayV3)),
                          ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {},
                child: Text(
                  'Sign in with a different account',
                  style: SubHeading.SH14,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
