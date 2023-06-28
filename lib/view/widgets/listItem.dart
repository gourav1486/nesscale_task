import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nesscale_task/business_logic/get_Items_bloc/bloc/get_items_bloc.dart';
import 'package:nesscale_task/business_logic/get_customers_bloc/bloc/get_customers_bloc.dart';
import 'package:nesscale_task/constants.dart';
import 'package:nesscale_task/expand_tile_cubit/cubit/expand_tile_cubit.dart';
import 'package:nesscale_task/helper/database_helper.dart';
import 'package:nesscale_task/models/invoice_model.dart';

class ListItem extends StatefulWidget {
  String itemName;
  String itemCode;
  String itemPrce;
  int id;

  ListItem(
      {Key? key,
      required this.itemCode,
      required this.itemName,
      required this.itemPrce,
      required this.id})
      : super(key: key);

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        surfaceTintColor: Colors.black,
        shadowColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
            height: 100,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: backgroundColor),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.itemName,
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          Text(
                            'code: ${widget.itemCode} ',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                          Text(
                            'Price: ${widget.itemPrce}',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    DataBaseHelper.deleteItem(widget.id);
                    BlocProvider.of<GetItemsBloc>(context).add(GetItemsList());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.delete_forever_outlined,
                      size: 30,
                      color: Colors.red[300],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class CustomerListItem extends StatefulWidget {
  String customerName;
  String mobileNo;
  String email;
  int id;
  CustomerListItem(
      {Key? key,
      required this.customerName,
      required this.mobileNo,
      required this.email,
      required this.id})
      : super(key: key);

  @override
  State<CustomerListItem> createState() => _CustomerListItemState();
}

class _CustomerListItemState extends State<CustomerListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        surfaceTintColor: Colors.black,
        shadowColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
            height: 100,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: backgroundColor),
                    child: Icon(
                      Icons.person_outline,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.customerName,
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            Text(
                              'Mobile: ${widget.mobileNo} ',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            ),
                            Text(
                              'Email: ${widget.email}',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    DataBaseHelper.deleteCustomers(widget.id);
                    BlocProvider.of<GetCustomersBloc>(context)
                        .add(GetCustomersListEvent());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.delete_forever_outlined,
                      size: 30,
                      color: Colors.red[300],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class InvoiceListItem extends StatefulWidget {
  String customerName;
  String date;
  List<Item> items;
  String grandTotal;
  InvoiceListItem(
      {Key? key,
      required this.customerName,
      required this.date,
      required this.grandTotal,
      required this.items})
      : super(key: key);

  @override
  State<InvoiceListItem> createState() => _InvoiceListItemState();
}

class _InvoiceListItemState extends State<InvoiceListItem> {
  @override
  bool _expanded = false;
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        surfaceTintColor: Colors.black,
        shadowColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          onTap: () {
            setState(() {
              _expanded = !_expanded;
            });
          },
          child: Container(
              height: _expanded ? widget.items.length * 110 + 100 : 100,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: backgroundColor),
                          child: Icon(
                            Icons.receipt_long,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.customerName,
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                Text(
                                  'Date: ${widget.date} ',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            child: Icon(
                          _expanded
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          size: 30,
                          color: Colors.red[300],
                        )),
                      )
                    ],
                  ),
                  if (_expanded) ...[
                    const Divider(),
                    ListView.builder(
                        itemCount: widget.items.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var itemDatails = widget.items[index];
                          return Container(
                            height: 40,
                            child: ListTile(
                              title: Text(
                                itemDatails.name,
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              trailing: Text(
                                '${itemDatails.rate.toString()} Rs.',
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                          );
                        }),
                    Divider(),
                    Container(
                      height: 40,
                      child: ListTile(
                        title: Text(
                          'GrandTotal',
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        trailing: Text(
                          '${widget.grandTotal} Rs.',
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ],
              )),
        ),
      ),
    );
  }
}
