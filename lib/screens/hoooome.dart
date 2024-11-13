

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stoor/screens/Home.dart';
import 'package:stoor/screens/loginn.dart';
import 'package:stoor/screens/profile.dart';

class Hoooome extends StatelessWidget {
  const Hoooome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), 
      builder: ((context,snapshot){
        if(snapshot.hasData){
          return ProfileScreen();
        }
        else
        {
          return HomeScren();
        }
      })),
    );
  }
}