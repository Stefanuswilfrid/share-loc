import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../../styles/fonts.dart';

class PickUsernameView extends StatefulWidget {
  @override
  PickUsernameViewState createState() => PickUsernameViewState();
}

class PickUsernameViewState extends State<PickUsernameView> {
  final usernameController = TextEditingController();
  bool isUsernameTaken = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: MColors.background,
          body: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 80, left: 20, right: 20, bottom: 50),
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
                          'Pick a username',
                          style: Heading.H26,
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Username',
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (errorMessage != null) Text(errorMessage!)
                      ],
                    ),
                  ),
                  Column(children: [
                    GestureDetector(
                      onTap: () async {},
                      child: Text(
                        'Sign in with a different account',
                        style: SubHeading.SH14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () async {},
                      child: Text('Next',
                          style:
                              SubHeading.SH18.copyWith(color: MColors.black)),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 28, vertical: 12),
                          backgroundColor: MColors.white,
                          minimumSize: Size(double.infinity, 50)),
                    ),
                  ])
                ],
              ),
            ),
          ),
        ));
  }
}
