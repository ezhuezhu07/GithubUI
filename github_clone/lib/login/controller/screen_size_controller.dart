import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ScreenSizeController extends GetxController {
  late double screenHeight;
  late double screenWidth;

  // Login in screen widget size

  late double appTitleTop;
  late double appTitleLeft;
  late double appTitleHeight;
  late double appTitleWidth;

  late double loginLottieAnimationTop;
  late double loginLottieAnimationLeft;
  late double loginLottieAnimationHeight;
  late double loginLottieAnimationWidth;

  late double signInWithGithubButtonTop;
  late double signInWithGithubButtonLeft;
  late double signInWithGithubButtonHeight;
  late double signInWithGithubButtonWidth;

  // Home Page widget size
  late double profileInfoContainerTop;
  late double profileInfoContainerLeft;
  late double profileInfoContainerHeight;
  late double profileInfoContainerWidth;

  late double listViewContainerTop;
  late double listViewContainerLeft;
  late double listViewContainerHeight;
  late double listViewContainerWidth;

  // Repo Page widget size
  late double repoInfoContainerTop;
  late double repoInfoContainerLeft;
  late double repoInfoContainerHeight;
  late double repoInfoContainerWidth;

  late double repoListViewContainerTop;
  late double repoListViewContainerLeft;
  late double repoListViewContainerHeight;
  late double repoListViewContainerWidth;

  void setSize(BuildContext context) async {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    appTitleTop = screenHeight * 0.1;
    appTitleLeft = screenWidth * 0.05;
    appTitleHeight = screenHeight * 0.1;
    appTitleWidth = screenWidth * 0.9;

    loginLottieAnimationTop = screenHeight * 0.3;
    loginLottieAnimationLeft = 0;
    loginLottieAnimationHeight = screenHeight * 0.3;
    loginLottieAnimationWidth = screenWidth;

    signInWithGithubButtonTop = screenHeight * 0.7;
    signInWithGithubButtonLeft = screenWidth * 0.05;
    signInWithGithubButtonHeight = screenHeight * 0.075;
    signInWithGithubButtonWidth = screenWidth * 0.9;

    profileInfoContainerTop = 0;
    profileInfoContainerLeft = 0;
    profileInfoContainerHeight = screenHeight * 0.15;
    profileInfoContainerWidth = screenWidth;

    listViewContainerTop = screenHeight * 0.16;
    listViewContainerLeft = 0;
    listViewContainerHeight = screenHeight;
    listViewContainerWidth = screenWidth;

    repoInfoContainerTop = 0;
    repoInfoContainerLeft = 0;
    repoInfoContainerHeight = screenHeight * 0.18;
    repoInfoContainerWidth = screenWidth;

    repoListViewContainerTop = screenHeight * 0.192;
    repoListViewContainerLeft = 0;
    repoListViewContainerHeight = screenHeight;
    repoListViewContainerWidth = screenWidth;
  }
}
