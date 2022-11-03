import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jobology/Screens/ForgetPass.dart';
import 'package:jobology/Screens/Home.dart';
import 'package:jobology/Screens/Login.dart';
import 'package:jobology/Screens/signup.dart';
import 'package:jobology/Screens/start.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

// raghad@firebase.com password: raghad12345
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(GetMaterialApp(
    themeMode: ThemeMode.system,
    theme: ThemeData(brightness: Brightness.light, primarySwatch: Colors.red),
    darkTheme:
        ThemeData(brightness: Brightness.dark, primarySwatch: Colors.purple),
    debugShowCheckedModeBanner: false,
    routes: {
      "Login": (context) => Login(),
      "Sign_Up": (context) => Sign_up(),
      "Home": (context) => Home(),
      "Start": (context) => Start_page(),
      "forgetpassword": (context) => ForgetPassword()
    },
    home: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Start_page();
  }
}
