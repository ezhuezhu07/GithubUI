import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:github_clone/LocalStorageService.dart';
import 'package:github_clone/app_secrets.dart';
import 'package:github_sign_in/github_sign_in.dart';

class AuthController extends GetxController {
  UserCredential? userCredential;

  Future<UserCredential> signInWithGitHub(BuildContext context) async {
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: AppSecrets.clientId,
        clientSecret: AppSecrets.clientSecret,
        redirectUrl: AppSecrets.redirectUrl,
        scope: 'repo,user,read:org,gist');

    final result = await gitHubSignIn.signIn(context);

    final githubCredentials = GithubAuthProvider.credential(result.token!);
    // print('Access token ${githubCredentials.accessToken}');
    final userCred =
        await FirebaseAuth.instance.signInWithCredential(githubCredentials);
    Get.find<LocalStorageService>()
        .userCred
        .write(userCred.user!.uid, userCred.credential!.accessToken);
    return userCred;
  }

  /*Future<UserCredential> signInWithGitHub(context) async {
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: AppSecrets.clientId,
        clientSecret: AppSecrets.clientSecret,
        redirectUrl: AppSecrets.redirectUrl);

    final result = await gitHubSignIn.signIn(context);
    // Create a new provider
    GithubAuthProvider githubProvider = GithubAuthProvider.credential();


    return await FirebaseAuth.instance.signInWithProvider(githubProvider);
  }*/

  void sigin(BuildContext context) async {
    userCredential = await signInWithGitHub(context);
  }
}
