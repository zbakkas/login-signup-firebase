import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScrren extends StatefulWidget {
  const ForgetPasswordScrren({super.key});

  @override
  State<ForgetPasswordScrren> createState() => _ForgetPasswordScrrenState();
}

class _ForgetPasswordScrrenState extends State<ForgetPasswordScrren> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(context: context, builder: (context){return AlertDialog(content: Text(e.message.toString()),);});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("enter your email"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: const Color.fromARGB(255, 241, 0, 0)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  border: InputBorder.none,
                  hintText: "email",
                  fillColor: const Color.fromARGB(66, 172, 170, 170),
                  filled: true),
            ),
          ),
          MaterialButton(
            onPressed: () => passwordReset(),
            child: Text("Reset Password"),
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}
