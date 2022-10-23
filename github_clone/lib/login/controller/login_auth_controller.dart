import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:github_clone/LocalStorageService.dart';
import 'package:github_clone/app_secrets.dart';
import 'package:github_sign_in/github_sign_in.dart';

class AuthController extends GetxController {
  UserCredential? userCredential;

  Future<UserCredential> signInWithGitHub(BuildContext context) async {
    // Authorize credentials with OAuth server
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: AppSecrets.clientId,
        clientSecret: AppSecrets.clientSecret,
        redirectUrl: AppSecrets.redirectUrl,
        scope: AppSecrets.scopes);

    // Github sign in web view
    // After login with user name password
    // It return back to the redirect url which we mentioned above and also return the access token [github authenticated token]
    final result = await gitHubSignIn.signIn(context);

    // create GithubProvider and sign in with Cred
    final githubCredentials = GithubAuthProvider.credential(result.token!);
    // For android and ios , firebase signin with cred is working
    // For web FirebaseAuth.instance.signInWithPopup(provider) use this method!!
    final userCred =
        await FirebaseAuth.instance.signInWithCredential(githubCredentials);

    // Storing the access token in local storage
    // Firebase Authentication only persists the credentials of the user for itself. It does not persist their credentials of the OAuth provider.
    Get.find<LocalStorageService>()
        .userCred
        .write(userCred.user!.uid, userCred.credential!.accessToken);
    return userCred;
  }

  void sigin(BuildContext context) async {
    userCredential = await signInWithGitHub(context);
  }
}
