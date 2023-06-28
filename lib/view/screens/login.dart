import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nesscale_task/view/screens/home_page.dart';
import '../../constants.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0.1 * MediaQuery.of(context).size.height,
              left: 0.27 * MediaQuery.of(context).size.width,
              child: Image.asset('assets/images/image 3.png')),
          Positioned(
            top: 0.5 * MediaQuery.of(context).size.height,
            left: 0.15 * MediaQuery.of(context).size.width,
            child: Container(
              height: 35,
              width: 0.75 * MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  'Welcome',
                  style: GoogleFonts.poppins(fontSize: 22),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0.6 * MediaQuery.of(context).size.height,
            left: 0.15 * MediaQuery.of(context).size.width,
            child: Container(
              height: 35,
              width: 0.75 * MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  'We are glad to see you. Please fill your information to continue',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Color(0xffff979797),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0.8 * MediaQuery.of(context).size.height,
            left: 0.10 * MediaQuery.of(context).size.width,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Container(
                height: 52,
                width: 0.826 * MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xffff572647),
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
