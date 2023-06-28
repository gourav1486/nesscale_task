import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nesscale_task/business_logic/bottom_navigatio_bar_index/cubit/bottom_navigation_bar_indexx_cubit_cubit.dart';
import 'package:nesscale_task/constants.dart';
import 'package:nesscale_task/view/screens/home_page.dart';
import 'package:nesscale_task/view/screens/invoice.dart';
import 'package:nesscale_task/view/screens/profile.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  int _currentIndex = 0;

  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBarIndexxCubitCubit,
        BottomNavigationBarIndexCubitState>(
      builder: (context, state) {
        state is IndexChanged ? _currentIndex = state.index : null;
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomePage()));
                      BlocProvider.of<BottomNavigationBarIndexxCubitCubit>(
                              context)
                          .changeIndex(0);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: _currentIndex == 0
                              ? backgroundColor
                              : Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.home_outlined,
                              size: 30,
                              color: _currentIndex != 0
                                  ? Colors.grey
                                  : Colors.white,
                            ),
                            _currentIndex == 0
                                ? Text(
                                    'Home',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                : SizedBox.shrink()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Invoices()));
                      BlocProvider.of<BottomNavigationBarIndexxCubitCubit>(
                              context)
                          .changeIndex(1);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: _currentIndex == 1
                              ? backgroundColor
                              : Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.receipt_long,
                              size: 30,
                              color: _currentIndex != 1
                                  ? Colors.grey
                                  : Colors.white,
                            ),
                            _currentIndex == 1
                                ? Text(
                                    'Invoice',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                : SizedBox.shrink()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<BottomNavigationBarIndexxCubitCubit>(
                              context)
                          .changeIndex(2);
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Profile()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: _currentIndex == 2
                              ? backgroundColor
                              : Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.person_outline,
                              size: 30,
                              color: _currentIndex != 2
                                  ? Colors.grey
                                  : Colors.white,
                            ),
                            _currentIndex == 2
                                ? Text(
                                    'Profile',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                : SizedBox.shrink()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
