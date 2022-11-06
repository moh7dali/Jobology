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
import 'package:jobology/Screens/Users/peronalPage/editProfile.dart';
import 'package:jobology/Screens/Welcome.dart';
import 'package:jobology/Screens/course.dart';
import 'package:jobology/Screens/interview.dart';
import 'package:jobology/Screens/jobInfo.dart';
import 'package:jobology/Screens/jobs.dart';

import 'package:jobology/Screens/start.dart';

import 'Screens/Authentication/ForgetPass.dart';
import 'Screens/Users/peronalPage/personalpage.dart';
import 'firebase_options.dart';

// raghad@firebase.com password: raghad12345

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(GetMaterialApp(
    themeMode: ThemeMode.system,
    theme: ThemeData(brightness: Brightness.light, primarySwatch: Colors.pink),
    darkTheme:
        ThemeData(brightness: Brightness.dark, primarySwatch: Colors.green),
    debugShowCheckedModeBanner: false,
    routes: {
      "Login": (context) => const Login(),
      "Sign_Up": (context) => const Sign_up(),
      "Company Sign up": (context) => Company_Sign_up(),
      "Home": (context) => Home(),
      "Start": (context) => const Start_page(),
      "forgetpassword": (context) => const ForgetPassword(),
      "jobInfo": (context) => const jobInfo(),
      "jobs": (context) => const jobs(),
      "course": (context) => const Course(),
      "personalPage": (context) => const personalInfo(),
      "welcome": (context) => Welcome(),
      "companyHome": (context) => CompanyHome(),
      "addNewPage": (context) => AddNewJob(),
      "addNewTraining": (context) => AddNewTraining(),
      "interview": (context) => InterView(),
      "editProfile":(context) => editProfile()
    },
    home: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Start_page();
  }
}
