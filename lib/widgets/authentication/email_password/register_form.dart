import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memz_clone/api/users/UserStore.dart';
import 'package:memz_clone/features/onboarding/VerifyEmail.dart';
import 'package:memz_clone/screens/authentication/email_password/sign_in_screen.dart';
import 'package:memz_clone/styles/colors.dart';
import 'package:memz_clone/styles/fonts.dart';
import 'package:memz_clone/utilsBoilerplate/authentication/email_password_auth/authentication.dart';
import 'package:memz_clone/utilsBoilerplate/authentication/email_password_auth/validator.dart';
import 'package:memz_clone/widgets/custom_form_field.dart';

import '../../../res/custom_colors.dart';

class RegisterForm extends StatefulWidget {
  final FocusNode nameFocusNode;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;

  const RegisterForm({
    Key? key,
    required this.nameFocusNode,
    required this.emailFocusNode,
    required this.passwordFocusNode,
  }) : super(key: key);
  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _registerFormKey = GlobalKey<FormState>();

  bool _isSigningUp = false;

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
            ),
            child: Column(
              children: [
                // CustomFormField(
                //   controller: _nameController,
                //   focusNode: widget.nameFocusNode,
                //   keyboardType: TextInputType.name,
                //   inputAction: TextInputAction.next,
                //   isCapitalized: true,
                //   validator: (value) => Validator.validateName(
                //     name: value,
                //   ),
                //   label: 'Username',
                //   hint: 'Enter a username',
                // ),
                // const SizedBox(height: 16.0),
                CustomFormField(
                  controller: _emailController,
                  focusNode: widget.emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  inputAction: TextInputAction.next,
                  validator: (value) => Validator.validateEmail(
                    email: value,
                  ),
                  label: 'Email',
                  hint: 'Enter your email',
                ),
                const SizedBox(height: 16.0),
                CustomFormField(
                  controller: _passwordController,
                  focusNode: widget.passwordFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.done,
                  validator: (value) => Validator.validatePassword(
                    password: value,
                  ),
                  isObscure: true,
                  label: 'Password',
                  hint: 'Enter your password',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),
          _isSigningUp
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Palette.firebaseOrange,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          MColors.white,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        widget.emailFocusNode.unfocus();
                        widget.passwordFocusNode.unfocus();

                        setState(() {
                          _isSigningUp = true;
                        });

                        if (_registerFormKey.currentState!.validate()) {
                          User? user =
                              await Authentication.registerUsingEmailPassword(
                            // name: _nameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            context: context,
                          );

                          if (user != null) {
                            await UserStore.addUser(user: user);
                            await user.sendEmailVerification().whenComplete(
                                  () => Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => VerifyEmailView(),
                                    ),
                                  ),
                                );
                          }
                        }

                        setState(() {
                          _isSigningUp = false;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Text(
                          'Sign Up',
                          style: SubHeading.SH18.copyWith(color: MColors.black),
                        ),
                      ),
                    ),
                  ),
                ),
          const SizedBox(height: 16.0),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(
                _routeToSignInScreen(),
              );
            },
            child: Text(
              'Already have an account? Sign in',
              style: TextStyle(
                color: Palette.firebaseGrey,
                letterSpacing: 0.5,
              ),
            ),
          )
        ],
      ),
    );
  }
}
