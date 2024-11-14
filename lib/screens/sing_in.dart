import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stoor/screens/loginn.dart';

class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();

  final provider = SettingsProvider();
   final formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  Future singUP() async {
    if (_confirmpasswordController.text.trim() ==
        _passwordController.text.trim() && (formKey.currentState?.validate() ?? false)) 
        {
      try {

        UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        addUserDetals(user.user!.uid, _firstNameController.text.trim(),
            _lastNameController.text.trim(), _emailController.text.trim());
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
    }
     else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
    
  }

  Future addUserDetals(String userUid, String firstname, String lastname, String email) async {
    await FirebaseFirestore.instance.collection('users').doc(userUid)
    .set({
      'first name': firstname,
      'lasr name': lastname,
      'email': email,
    });
  }

  void openscreensignin() {
    Navigator.of(context).pushReplacementNamed('loginScreen');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController..dispose();
    super.dispose();
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
                // Image.asset("images/loginn.png", width: 200, height: 200),
                Text(
                  "Create Your Account",
                  style: GoogleFonts.robotoCondensed(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Please enter your details to sign Up",
                  style: TextStyle(fontSize: 16),
                ),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.robotoCondensed(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.withOpacity(0.9)),
                    ),
                  ),
                ),
                InoutFiledd(
                  label: 'first name',
                  icon: Icons.person,
                  validator: (value) =>
                      provider.validator(value, "Please enter your email"),
                  controller: _firstNameController,
                  inputFornatter: [],
                  inputType: TextInputType.text,
                ),
            
                InoutFiledd(
                  label: 'last name',
                  icon: Icons.person,
                  validator: (value) =>
                      provider.validator(value, "Please enter your email"),
                  controller: _lastNameController,
                  inputFornatter: [],
                  inputType: TextInputType.text,
                ),
                InoutFiledd(
                  label: 'email',
                  icon: Icons.email_outlined,
                  validator: (value) =>
                      provider.validator(value, "Please enter your email"),
                  controller: _emailController,
                  inputFornatter: [],
                  inputType: TextInputType.emailAddress,
                ),
            
                InoutFiledd(
                  label: 'Password',
                  icon: Icons.lock,
                  validator: (value) =>
                      provider.confirmpassord(value,_confirmpasswordController.text.trim(), " password"),
                  controller: _passwordController,
                  inputFornatter: [],
                  inputType: TextInputType.text,
                  isPassword: true, // Enable visibility toggle for password
                ),
                InoutFiledd(
                  label: 'confirm Password',
                  icon: Icons.lock,
                  validator: (value) =>
                      provider.confirmpassord(value, _passwordController.text.trim()," password"),
                  controller: _confirmpasswordController,
                  inputFornatter: [],
                  inputType: TextInputType.text,
                  isPassword: true, // Enable visibility toggle for password
                ),
            
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Checkbox(
                        value: _isChecked,
                        onChanged: (bool? newValue) {
                          setState(() {
                            _isChecked = newValue!;
                          });
                        },
                      ),
                    ),
                    const Text("I agree to the terms and conditions"),
                  ],
                ),
            
                // SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                    onTap: () => singUP(),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "if you have an acounte ",
                      ),
                      GestureDetector(
                        onTap: () => openscreensignin(),
                        child: Text(
                          "Login",
                          style: GoogleFonts.robotoCondensed(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
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
