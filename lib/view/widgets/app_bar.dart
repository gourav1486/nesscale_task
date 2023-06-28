import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class AppBarWithoutNavigation extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  AppBarWithoutNavigation({Key? key,required this.title,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Center(child: Text(title,style: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.white
      ),),),
    );
  }
}
class AppBars extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  AppBars({Key? key,required this.title, required this.onPressed}) : super(key: key);

  @override
  State<AppBars> createState() => _AppBarsState();
}

class _AppBarsState extends State<AppBars> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Row(
        children: [
          InkWell(
            onTap: widget.onPressed,
            child: Container(
                width: 0.1*MediaQuery.of(context).size.width,
                child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
          ),
          Container(
            width: 0.8*MediaQuery.of(context).size.width,
            child: Center(child: Text(widget.title,style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white
            ),),),
          ),
        
        ],
      ),
    );
  }
}
