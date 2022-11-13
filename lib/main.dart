import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobology/Screens/Authentication/Company_signup.dart';
import 'package:jobology/Screens/Authentication/Login.dart';
import 'package:jobology/Screens/Authentication/signup.dart';
import 'package:jobology/Screens/Company/AddNewJob.dart';
import 'package:jobology/Screens/Company/AddNewTraining.dart';
import 'package:jobology/Screens/Company/HomeCompany.dart';
import 'package:jobology/Screens/Users/Home.dart';
import 'package:jobology/Screens/Users/cv.dart';
import 'package:jobology/Screens/Users/interview_preview.dart';
import 'package:jobology/Screens/Welcome.dart';
import 'package:jobology/Screens/Users/course.dart';
import 'package:jobology/Screens/Users/jobs.dart';
import 'package:jobology/Screens/start.dart';
import 'package:jobology/Widgets/ck_login.dart';
import 'Screens/Authentication/ForgetPass.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(GetMaterialApp(
    themeMode: ThemeMode.system,
    theme: ThemeData(brightness: Brightness.light),
    darkTheme: ThemeData(brightness: Brightness.dark),
    debugShowCheckedModeBanner: false,
    routes: {
      "Login": (context) => Login(),
      "Sign_Up": (context) => Sign_up(),
      "Check": (context) => const Check(),
      "Company Sign up": (context) => Company_Sign_up(),
      "Home": (context) => Home(),
      "Start": (context) => const Start_page(),
      "forgetpassword": (context) => const ForgetPassword(),
      "jobs": (context) => const jobs(),
      "course": (context) => const Course(),
      "welcome": (context) => Welcome(),
      "companyHome": (context) => CompanyHome(),
      "addNewJob": (context) => AddNewJob(),
      "addNewTraining": (context) => AddNewTraining(),
      "cv": (context) => Cv(),
      "interview": (context) => Interviwe_Preview(),
    },
    home: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Check();
  }
}
