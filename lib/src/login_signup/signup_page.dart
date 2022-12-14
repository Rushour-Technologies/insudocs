import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:insudox/src/common_widgets/base_components.dart';
import 'package:insudox/globals.dart';
import 'package:insudox/src/login_signup/components.dart';
import 'package:insudox/services/Firebase/fireauth/fireauth.dart';
import 'package:insudox/src/login_signup/details_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  /// The route name for this page.
  static const routeName = '/signup';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;
  String errorTextEmail = '',
      errorTextPassword = '',
      errorTextConfirmPassword = '';

  Future<void> register(screenHeight) async {
    if (confirmPasswordController.text != passwordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Passwords do not match!",
            style: TextStyle(
              fontFamily: 'Cabin',
              fontSize: screenHeight * 0.035,
              color: GlobalColor.snackbarText,
            ),
          ),
          backgroundColor: GlobalColor.snackbarBg,
        ),
      );
      // errorTextPassword = errorTextConfirmPassword = "Passwords do not match!";
    } else {
      List<dynamic> result = await registerUser(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );

      // print(result);
      if (result[0] == 0) {
        Navigator.of(context).restorablePushNamedAndRemoveUntil(
            DetailsPage.routeName, (route) => false);
        passwordController.text =
            confirmPasswordController.text = emailController.text = '';
        return;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result[1].toString().capitalized,
              style: TextStyle(
                fontFamily: 'Cabin',
                fontSize: screenHeight * 0.035,
                color: GlobalColor.snackbarText,
              ),
            ),
            backgroundColor: GlobalColor.snackbarBg,
          ),
        );
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return baseBackground(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.dstATop),
              repeat: ImageRepeat.repeatX,
              image: const AssetImage(
                'assets/images/design_pattern.png',
              ),
            ),
            borderRadius: BorderRadius.circular(screenHeight / 20),
            color: GlobalColor.secondary,
          ),
          height: screenHeight * 0.8,
          width: screenWidth * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'assets/images/woman.png',
                width: screenHeight * 0.3,
                height: screenHeight * 0.3,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.05,
                ),
                child: Column(
                  children: [
                    headingCard(
                      screenWidth: screenWidth,
                      title: 'CREATE YOUR ACCOUNT',
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.04,
                      ),
                      child: SizedBox(
                        width: screenWidth * 0.3,
                        height: screenHeight * 0.06,
                        child: normalformfield(
                          nameController,
                          screenHeight,
                          setState,
                          'Your first & last name',
                          TextInputType.name,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.02,
                      ),
                      child: SizedBox(
                        width: screenWidth * 0.3,
                        height: screenHeight * 0.06,
                        child: emailformfield(
                          emailController,
                          screenHeight,
                          setState,
                          errorTextEmail,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.02,
                      ),
                      child: SizedBox(
                        width: screenWidth * 0.3,
                        height: screenHeight * 0.06,
                        child: PasswordFormField(
                          passwordController: passwordController,
                          errorTextPassword: errorTextPassword,
                          hintText: 'Enter password',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.02,
                      ),
                      child: SizedBox(
                        width: screenWidth * 0.3,
                        height: screenHeight * 0.06,
                        child: PasswordFormField(
                          passwordController: confirmPasswordController,
                          errorTextPassword: errorTextPassword,
                          hintText: "Confirm Password",
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.025),
                      child: ORWidget(
                          screenHeight: screenHeight, screenWidth: screenWidth),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.025),
                      child: googleSignInCard(
                        context,
                        screenHeight,
                        screenWidth,
                        signIn: true,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.025),
                      child: continueCard(
                        screenWidth,
                        screenHeight,
                        onClickFunction: register,
                        setState: setState,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.025),
                      child: continueCard(screenWidth, screenHeight,
                          onClickFunction: (value) async {
                        Navigator.of(context).restorablePushNamedAndRemoveUntil(
                            '/login', (route) => false);
                      },
                          setState: setState,
                          title: 'Already have an account?\n Login',
                          widthPercent: 0.15),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      width: screenWidth,
      height: screenHeight,
    );
  }
}
