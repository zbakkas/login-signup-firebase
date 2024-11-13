import 'package:flutter/material.dart';
import 'package:stoor/screens/ForgetPasswordScrren.dart';
import 'package:stoor/screens/Home.dart';
import 'package:stoor/screens/hoooome.dart';
import 'package:stoor/screens/loginn.dart';
import 'package:stoor/screens/profile.dart';
import 'package:stoor/screens/sing_in.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // home: Hoooome(),
    routes: {

      '/' : (context)=>const Hoooome(),
      'homescreen': (context)=>const HomeScren(),
      'loginScreen':(context)=>const LoginScreen(),
      'SingInScreen':(context)=>const SingInScreen(),
      'ForgetPasswordScrren':(context)=>const ForgetPasswordScrren(),
      'profile': (context) => const ProfileScreen(),
    },
  ));
}
