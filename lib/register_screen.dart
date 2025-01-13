import 'package:demo_supabase_app/auth/auth_service.dart';
import 'package:demo_supabase_app/home_screen.dart';
import 'package:demo_supabase_app/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sign Up',
                style: GoogleFonts.alumniSans(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 32.0,
                  ),
                ),
              ),
              70.heightBox,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                ),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  style: GoogleFonts.alumniSans(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 15.0,
                    ),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter email address',
                    labelText: 'Email',
                  ),
                ),
              ),
              20.heightBox,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                ),
                child: TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  style: GoogleFonts.alumniSans(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 15.0,
                    ),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter password here',
                    labelText: 'Password',
                  ),
                ),
              ),
              20.heightBox,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                ),
                child: TextFormField(
                  controller: confirmPasswordController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  style: GoogleFonts.alumniSans(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 15.0,
                    ),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter confirm password here',
                    labelText: 'Confirm Password',
                  ),
                ),
              ),
              50.heightBox,
              InkWell(
                onTap: () {
                  // Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => HomeScreen()));
                  attemptSignUp();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 1.0,
                  height: 50.0,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Center(
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.alumniSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              20.heightBox,
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text(
                  'Already have an account? Log In',
                  style: GoogleFonts.alumniSans(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void attemptSignUp() async {
    String email = emailController.text.toString();
    String password = passwordController.text.toString();
    String conPassword = confirmPasswordController.text.toString();

    if (password != conPassword) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password don\'t matched.')));
      return;
    }

    try {
      await authService.signUpWithEmailPassword(email, password);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }
}
