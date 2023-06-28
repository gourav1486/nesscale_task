import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nesscale_task/business_logic/bottom_navigatio_bar_index/cubit/bottom_navigation_bar_indexx_cubit_cubit.dart';
import 'package:nesscale_task/business_logic/get_Items_bloc/bloc/get_items_bloc.dart';
import 'package:nesscale_task/business_logic/get_customers_bloc/bloc/get_customers_bloc.dart';
import 'package:nesscale_task/business_logic/invoice_list_bloc/bloc/invoice_list_bloc.dart';
import 'package:nesscale_task/expand_tile_cubit/cubit/expand_tile_cubit.dart';
import 'package:nesscale_task/view/screens/customer.dart';
import 'package:nesscale_task/view/screens/home_page.dart';
import 'package:nesscale_task/view/screens/items.dart';
import 'package:nesscale_task/view/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavigationBarIndexxCubitCubit>(
          create: (context) => BottomNavigationBarIndexxCubitCubit(),
        ),
        BlocProvider<ExpandTileCubit>(
          create: (context) => ExpandTileCubit(),
        ),
        BlocProvider<GetItemsBloc>(
          create: (context) => GetItemsBloc(),
        ),
        BlocProvider<InvoiceListBloc>(
          create: (context) => InvoiceListBloc(),
        ),
        BlocProvider<GetCustomersBloc>(
          create: (context) => GetCustomersBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const Login(),
      ),
    );
  }
}
