import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nesscale_task/constants.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  CustomButton({Key? key, required this.title, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 52,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: backgroundColor),
            child: Center(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ));
  }
}
