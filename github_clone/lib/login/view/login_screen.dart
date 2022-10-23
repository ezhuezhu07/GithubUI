import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:github_clone/colors.dart';
import 'package:github_clone/login/controller/login_auth_controller.dart';
import 'package:github_clone/login/controller/screen_size_controller.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Creating the size controller and authController
    Get.put(ScreenSizeController());
    Get.put(AuthController());

    return Material(
      child: Scaffold(
        body: GetBuilder<ScreenSizeController>(
            init: ScreenSizeController(),
            builder: (sizeController) {
              sizeController.setSize(context);
              return Container(
                height: sizeController.screenHeight,
                width: sizeController.screenWidth,
                color: dark,
                child: Stack(
                  children: [
                    // title widget
                    Positioned(
                        top: sizeController.appTitleTop,
                        left: sizeController.appTitleLeft,
                        child: SizedBox(
                            height: sizeController.appTitleHeight,
                            width: sizeController.appTitleWidth,
                            child: const Center(
                                child: FittedBox(
                              fit: BoxFit.cover,
                              child: Text(
                                "Github Clone",
                                style: TextStyle(
                                  color: white,
                                  fontSize: 32,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )))),
                    // lottie github animation
                    Positioned(
                      top: sizeController.loginLottieAnimationTop,
                      left: sizeController.loginLottieAnimationLeft,
                      child: SizedBox(
                        height: sizeController.loginLottieAnimationHeight,
                        width: sizeController.loginLottieAnimationWidth,
                        child: Center(
                            child: Lottie.asset('assets/github-icon.json')),
                      ),
                    ),
                    // github sign in button
                    Positioned(
                      top: sizeController.signInWithGithubButtonTop,
                      left: sizeController.signInWithGithubButtonLeft,
                      child: SizedBox(
                        height: sizeController.signInWithGithubButtonHeight,
                        width: sizeController.signInWithGithubButtonWidth,
                        child: ElevatedButton.icon(
                          icon: const FaIcon(
                            FontAwesomeIcons.github,
                            color: Colors.black,
                            size: 32,
                          ),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(white),
                              shadowColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return white;
                                }
                                if (states.contains(MaterialState.pressed)) {
                                  return dark;
                                }
                                return null; // Defer to the widget's default.
                              })),
                          onPressed: () {
                            // calling the sigin in method
                            Get.find<AuthController>().sigin(context);
                          },
                          label: const FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Sign In With Github',
                                style: TextStyle(),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
