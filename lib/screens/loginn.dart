import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final provider = SettingsProvider();
  final formKey = GlobalKey<FormState>();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  Future singIN() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        Navigator.of(context).pushNamed('/');
      } on FirebaseAuthException catch (e) {
        print(e);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          },
        );
      }
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  void openscreensignin() {
    Navigator.of(context).pushReplacementNamed('SingInScreen');
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.blue,
      //   elevation: 0,
      // ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            autovalidateMode: _autovalidateMode,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("images/loginn.png", width: 200, height: 200),
                Text(
                  "Welcome back",
                  style: GoogleFonts.robotoCondensed(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Please enter your details to Login",
                  style: TextStyle(fontSize: 16),
                ),

                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "Login",
                      style: GoogleFonts.robotoCondensed(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.withOpacity(0.9)),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25),
                //   child: TextFormField(
                //     controller: _emailController,
                //     decoration: InputDecoration(
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //             color: const Color.fromARGB(255, 241, 0, 0)),
                //         borderRadius: BorderRadius.circular(15),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.blue),
                //         borderRadius: BorderRadius.circular(15),
                //       ),
                //       border: InputBorder.none,
                //       hintText: "email",
                //       fillColor: const Color.fromARGB(253, 252, 250, 250),
                //       filled: true,
                //     ),
                //   ),
                // ),

                // Email field without visibility toggle
                InoutFiledd(
                  label: 'Email',
                  icon: Icons.email_outlined,
                  validator: (value) =>
                      provider.validator(value, "Please enter your email"),
                  controller: _emailController,
                  inputFornatter: [],
                  inputType: TextInputType.emailAddress,
                ),

                // Password field with visibility toggle
                InoutFiledd(
                  label: 'Password',
                  icon: Icons.lock,
                  validator: (value) =>
                      provider.validator(value, "Please enter your password"),
                  controller: _passwordController,
                  inputFornatter: [],
                  inputType: TextInputType.text,
                  isPassword: true, // Enable visibility toggle for password
                ),

                // SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'ForgetPasswordScrren');
                      },
                      child: Text(
                        "forgot Password?",
                        style: GoogleFonts.robotoCondensed(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 26,
                    )
                  ],
                ),
                // SizedBox(height: 10,),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: GestureDetector(
                    onTap: () => singIN(),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "if you don't have an acounte ",
                      style: GoogleFonts.robotoCondensed(
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () => openscreensignin(),
                      child: Text(
                        "sing Up",
                        style: GoogleFonts.robotoCondensed(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey, // Line color
                          thickness: 1, // Line thickness
                          endIndent: 10, // Spacing between line and text
                        ),
                      ),
                      Text(
                        "our",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey, // Line color
                          thickness: 1, // Line thickness
                          indent: 10, // Spacing between line and text
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        // Add your Google sign-in logic here
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: Colors.grey), // Border color and thickness
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Rounded corners
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15), // Padding inside the button
                        backgroundColor: Colors.white,
                      ),
                      child: Image.asset(
                        'images/google_logo.png', // Path to the Google logo
                        height: 24, // Adjust logo size
                        width: 24,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        // Add your Google sign-in logic here
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: Colors.grey), // Border color and thickness
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Rounded corners
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15), // Padding inside the button
                        backgroundColor: Colors.white,
                      ),
                      child: Image.asset(
                        'images/facebook.png', // Path to the Google logo
                        height: 24, // Adjust logo size
                        width: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsProvider extends ChangeNotifier {
  validator(String value, String message) {
    if (value.isEmpty) {
      return message;
    } else
      return null;
  }

  confirmpassord(
    String value1,
    String value2,
    String message,
  ) {
    if (value1 == value2) {
      return null;
    } 
    else {
      return message;
    }
    
  }
}
//////

class InoutFiledd extends StatefulWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final FormFieldValidator validator;
  final List<TextInputFormatter>? inputFornatter;
  final TextInputType inputType;
  final bool isPassword;

  const InoutFiledd({
    super.key,
    required this.label,
    required this.icon,
    required this.validator,
    required this.controller,
    required this.inputFornatter,
    required this.inputType,
    this.isPassword = false, // Default to false if not specified
  });

  @override
  _InoutFileddState createState() => _InoutFileddState();
}

class _InoutFileddState extends State<InoutFiledd> {
  bool _isVisible = false;

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        inputFormatters: widget.inputFornatter,
        keyboardType: widget.inputType,
        obscureText:
            widget.isPassword && !_isVisible, // Toggle only for password fields
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.label,
          prefixIcon: Icon(widget.icon),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _isVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: _toggleVisibility,
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(color: Colors.grey.withOpacity(0.4), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(color: Colors.indigo.withOpacity(0.4), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(color: Colors.red.withOpacity(0.4), width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(color: Colors.red.withOpacity(0.4), width: 2),
          ),
        ),
      ),
    );
  }
}
