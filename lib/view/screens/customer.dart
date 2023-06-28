import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nesscale_task/business_logic/get_customers_bloc/bloc/get_customers_bloc.dart';
import 'package:nesscale_task/constants.dart';
import 'package:nesscale_task/helper/database_helper.dart';
import 'package:nesscale_task/view/screens/home_page.dart';
import 'package:nesscale_task/view/widgets/app_bar.dart';
import 'package:nesscale_task/view/widgets/button.dart';
import 'package:nesscale_task/view/widgets/floating_action_button.dart';
import 'package:nesscale_task/view/widgets/listItem.dart';
import 'package:nesscale_task/view/widgets/test_form_fields.dart';

class Customers extends StatefulWidget {
  const Customers({Key? key}) : super(key: key);

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetCustomersBloc>(context).add(GetCustomersListEvent());
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              color: backgroundColor,
              child: Column(
                children: [
                  AppBars(
                    title: 'Customers',
                    onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomePage())),
                  )
                ],
              ),
            ),
            Positioned(
              top: 0.2 * MediaQuery.of(context).size.height,
              left: 0,
              child: BlocBuilder<GetCustomersBloc, GetCustomersState>(
                builder: (context, state) {
                  return state is GetCustomersList
                      ? Container(
                          height: 0.8 * MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: state.customer.length == 0
                              ? Center(
                                  child: Text(
                                    'No Customers Found',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: state.customer.length,
                                  itemBuilder: (context, index) {
                                    var customerInfo = state.customer[index];
                                    return CustomerListItem(
                                      customerName:
                                          customerInfo['customerName'],
                                      mobileNo: customerInfo['mobileNumber'],
                                      email: customerInfo['email'],
                                      id: customerInfo['id'],
                                    );
                                  }),
                        )
                      : SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButtonS(
          title: 'Add Customer',
          onPressed: _addCustomer,
        ));
  }

  _addCustomer() {
    final _key = GlobalKey<FormState>();
    TextEditingController _customerName = TextEditingController();
    TextEditingController _mobileNumber = TextEditingController();
    TextEditingController _customerEmail = TextEditingController();
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15))),
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)),
                color: Colors.white,
              ),
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Add Customer',
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextFormFields(
                        controller: _customerName,
                        hintText: 'Enter Customer Name',
                        labelText: 'Customer Name'),
                    TextFormFields(
                        controller: _mobileNumber,
                        hintText: 'Customer Mobile Number',
                        labelText: 'Mobile Number'),
                    TextFormFields(
                        controller: _customerEmail,
                        hintText: 'Customer Email Address',
                        labelText: 'Email Address'),
                    CustomButton(
                        title: 'Add Customer',
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            DataBaseHelper.createCustomer(_customerName.text,
                                _mobileNumber.text, _customerEmail.text);
                            BlocProvider.of<GetCustomersBloc>(context)
                                .add(GetCustomersListEvent());
                            Navigator.of(context).pop();
                          }
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
