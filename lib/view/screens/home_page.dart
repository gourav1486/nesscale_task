import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nesscale_task/constants.dart';
import 'package:nesscale_task/view/screens/customer.dart';
import 'package:nesscale_task/view/screens/items.dart';
import 'package:nesscale_task/view/widgets/app_bar.dart';
import 'package:nesscale_task/view/widgets/bottom_navigation_bar.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            color: backgroundColor,
            child: Column(
              children: [AppBarWithoutNavigation(title: 'HomePage',onPressed: (){

              },)],
            ),
          ),
          Positioned(
              top: 0.2 * MediaQuery.of(context).size.height,
              left: 0,
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: InkWell(
                          onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Customers())),
                          child: Card(
                            elevation: 2,
                            color: Color(0xffff644D99FF),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person_outline, size: 70, color: Colors.white,),
                              Text('Customers', style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white
                              ),)
                            ],
                          ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: InkWell(
                          onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Items())),
                          child: Card(
                            elevation: 2,
                            color: Color(0xffff644D99FF),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_cart_outlined, size: 70, color: Colors.white,),
                              Text('Items', style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white
                              ),)
                            ],
                          ),
                          ),
                        ),
                      )
                    ],
                  )))
        ],
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
