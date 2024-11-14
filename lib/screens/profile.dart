import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;
  List data = [];
  String? usrename;
  Map? datas;
  Future<void> getdata() async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();
    datas = querySnapshot.data();
    // usrename = data!["first name"];
    print(
        "----------------------------=========------------------------------------");
    // debugPrint("the value is: ${data!["email"]}");
    print("----------------------------------------------------------------");
    print(querySnapshot.data());
    setState(() {});
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user!.email!),
            Text("user name : ${datas?["first name"] ?? ""}"),
             Text("last name : ${datas?["lasr name"] ?? ""}"),
            MaterialButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              color: Colors.blue,
              child: Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}
