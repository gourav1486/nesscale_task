import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nesscale_task/business_logic/get_Items_bloc/bloc/get_items_bloc.dart';
import 'package:nesscale_task/business_logic/get_customers_bloc/bloc/get_customers_bloc.dart';
import 'package:nesscale_task/business_logic/invoice_list_bloc/bloc/invoice_list_bloc.dart';
import 'package:nesscale_task/constants.dart';
import 'package:nesscale_task/expand_tile_cubit/cubit/expand_tile_cubit.dart';
import 'package:nesscale_task/helper/database_helper.dart';
import 'package:nesscale_task/models/invoice_model.dart';
import 'package:nesscale_task/view/screens/items.dart';
import 'package:nesscale_task/view/widgets/app_bar.dart';
import 'package:nesscale_task/view/widgets/bottom_navigation_bar.dart';
import 'package:nesscale_task/view/widgets/button.dart';
import 'package:nesscale_task/view/widgets/floating_action_button.dart';
import 'package:nesscale_task/view/widgets/listItem.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Invoices extends StatefulWidget {
  const Invoices({Key? key}) : super(key: key);

  @override
  State<Invoices> createState() => _InvoicesState();
}

class _InvoicesState extends State<Invoices> {
  List items = ['Item1', 'Item2', 'Item3'];
  @override
  bool expanded = false;
  void initState() {
    super.initState();
    BlocProvider.of<GetItemsBloc>(context).add(GetItemsList());
    BlocProvider.of<InvoiceListBloc>(context).add(GetInvoice());
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
                AppBarWithoutNavigation(
                  title: 'Invoices',
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Positioned(
            top: 0.2 * MediaQuery.of(context).size.height,
            left: 0,
            child: BlocBuilder<InvoiceListBloc, InvoiceListState>(
                builder: (context, state) {
              return state is InvoiceListLoaded
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: ListView.builder(
                          itemCount: state.invoices.length,
                          itemBuilder: (context, index) {
                            var invoiceData = state.invoices[index];
                            return InvoiceListItem(
                              customerName: invoiceData.customer,
                              date: invoiceData.date,
                              items: invoiceData.items,
                              grandTotal: invoiceData.grandTotal.toString(),
                            );
                          }),
                    )
                  : SizedBox.shrink();
            }),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(),
      floatingActionButton: FloatingActionButtonS(
        title: 'Create Invoices',
        onPressed: _createInvoice,
      ),
    );
  }

  String customer = '';
  _createInvoice() {
    final _key = GlobalKey<FormState>();
    List<Item> selectedItems = [];
    List<int> selectedItemId = [];
    bool _selectAll = false;
    double total = 0;
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15))),
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
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
                          'Add Invoice',
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          child: Column(
                            children: [
                              BlocBuilder<GetCustomersBloc, GetCustomersState>(
                                builder: (context, state) {
                                  return state is GetCustomersList
                                      ? DropdownButtonFormField(
                                          decoration: InputDecoration(
                                            hintText: 'Select Customer',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color: backgroundColor),
                                            ),
                                          ),
                                          items: state.customer
                                              .map((e) => DropdownMenuItem(
                                                  child: Text(
                                                    e['customerName'],
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 16),
                                                  ),
                                                  value: e['customerName']))
                                              .toList(),
                                          onChanged: (value) {
                                            customer = value.toString();
                                          })
                                      : SizedBox.shrink();
                                },
                              ),
                              BlocBuilder<GetItemsBloc, GetItemsState>(
                                builder: (context, state) {
                                  return state is ItemsLoadedState
                                      ? Column(
                                          children: [
                                            CheckboxListTile(
                                              title: Text(
                                                'Select All',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 16),
                                              ),
                                              value: _selectAll,
                                              onChanged: (value) {
                                                _selectAll = !_selectAll;
                                                if (_selectAll) {
                                                  setState(
                                                    () {
                                                      state.itemsList
                                                          .forEach((element) {
                                                        selectedItemId
                                                            .add(element['id']);
                                                        total +=
                                                            element['rate'];
                                                      });
                                                    },
                                                  );
                                                } else {
                                                  setState(() {
                                                    selectedItemId.clear();
                                                    total = 0;
                                                  });
                                                }
                                              },
                                            ),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: state.itemsList.length,
                                              itemBuilder: (context, index) {
                                                final item =
                                                    state.itemsList[index];
                                                final isSelected =
                                                    selectedItemId
                                                        .contains(item['id']);

                                                return CheckboxListTile(
                                                  title: Text(
                                                    item['name'],
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 16),
                                                  ),
                                                  value: isSelected,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      if (value != null &&
                                                          value) {
                                                        selectedItemId
                                                            .add(item['id']);
                                                        total += item['rate'];
                                                      } else {
                                                        selectedItemId
                                                            .remove(item['id']);
                                                        total -= item['rate'];
                                                      }
                                                    });
                                                  },
                                                );
                                              },
                                            ),
                                            Text(
                                              'Grand Total : $total',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 18),
                                            ),
                                            CustomButton(
                                                title: 'Add Invoice',
                                                onPressed: () async {
                                                  if (_key.currentState!
                                                      .validate()) {
                                                    state.itemsList
                                                        .forEach((element) {
                                                      if (selectedItemId
                                                          .contains(
                                                              element['id'])) {
                                                        selectedItems.add(Item(
                                                            name:
                                                                element['name'],
                                                            rate:
                                                                element['rate'],
                                                            code:
                                                                element['code'],
                                                            id: element['id']));
                                                      }
                                                    });
                                                    var invoice = Invoice(
                                                        date: DateTime.now()
                                                            .toString(),
                                                        customer: customer,
                                                        items: selectedItems,
                                                        grandTotal: total);
                                                    await DataBaseHelper
                                                            .createInvoice(
                                                                invoice)
                                                        .then((value) {
                                                      BlocProvider.of<
                                                                  InvoiceListBloc>(
                                                              context)
                                                          .add(GetInvoice());
                                                      Navigator.of(context)
                                                          .pop();
                                                    });
                                                  }
                                                }),
                                          ],
                                        )
                                      : SizedBox.shrink();
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}
