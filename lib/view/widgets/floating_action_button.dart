import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nesscale_task/constants.dart';

class FloatingActionButtonS extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  FloatingActionButtonS(
      {Key? key, required this.title, required this.onPressed})
      : super(key: key);

  @override
  State<FloatingActionButtonS> createState() => _FloatingActionButtonSState();
}

class _FloatingActionButtonSState extends State<FloatingActionButtonS> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: FloatingActionButton(
        backgroundColor: backgroundColor,
        highlightElevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        onPressed: widget.onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
