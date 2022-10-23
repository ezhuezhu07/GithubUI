import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:github_clone/LocalStorageService.dart';
import 'package:github_clone/colors.dart';
import 'package:github_clone/firebase_options.dart';
import 'package:github_clone/homescreen/view/github_home_screen.dart';
import 'package:github_clone/login/view/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initStorageServices();
  runApp(const App());
}

Future<void> initStorageServices() async {
  // Initialized storage services
  await GetStorage.init('UserCred');
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Github',
      debugShowCheckedModeBanner: false,
      // theme added !! Inspired from public github repo
      theme: ThemeData(
        primaryColor: primary,
        backgroundColor: dark,
        scaffoldBackgroundColor: black,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: dark,
        ),
        appBarTheme: const AppBarTheme(
            elevation: 0,
            color: dark,
            iconTheme: IconThemeData(color: primary)),
        textTheme: const TextTheme(
            bodyText1: TextStyle(
              color: white,
            ),
            headline6: TextStyle(fontWeight: FontWeight.w600)),
      ),
      // For persisting the user session, Checking firebase authStateChanges
      // If it returns the user data , push it to the HomePage
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, userSnapShotData) {
            if (!userSnapShotData.hasData) {
              return const LoginPage();
            } else if (userSnapShotData.connectionState ==
                ConnectionState.waiting) {
              return const CircularProgressIndicator(
                color: Colors.white,
                value: 10.0,
              );
            } else {
              return const GitHubHomePage();
            }
          }),
      initialBinding: BindingsBuilder(() => {
            Get.put(LocalStorageService().init()),
          }),
    );
  }
}
