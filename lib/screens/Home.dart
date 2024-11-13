import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScren extends StatefulWidget {
  const HomeScren({super.key});

  @override
  State<HomeScren> createState() => _HomeScrenState();
}

class _HomeScrenState extends State<HomeScren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
    body: Center(
      child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
        children: [
            Text("Welcome to my app",style: GoogleFonts.robotoCondensed(fontSize: 40,fontWeight:FontWeight.bold),),
            Text("Create an account to get started ", style: TextStyle(fontSize: 18),),
          Image.asset("images/loginn.png"),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 25),
          //   child: Container(
          //     decoration: BoxDecoration(color: Colors.white,
          //     borderRadius: BorderRadius.circular(15)),
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 12),
          //       child: TextField(decoration: InputDecoration(
          //         border: InputBorder.none,
          //         hintText: "email"      
          //       ),),
          //     ),
          //   ),
          // ),
          SizedBox(height: 15,),
          
            Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                    onTap: (){ Navigator.pushNamed(context, 'loginScreen');},
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
              SizedBox(height: 10,),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                    onTap: (){ Navigator.pushNamed(context, 'SingInScreen');},
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



        ],
      ),
    ),
    )
    ;
  }
}

