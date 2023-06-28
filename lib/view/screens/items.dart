import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nesscale_task/business_logic/get_Items_bloc/bloc/get_items_bloc.dart';
import 'package:nesscale_task/constants.dart';
import 'package:nesscale_task/helper/database_helper.dart';
import 'package:nesscale_task/view/screens/home_page.dart';
import 'package:nesscale_task/view/widgets/app_bar.dart';
import 'package:nesscale_task/view/widgets/button.dart';
import 'package:nesscale_task/view/widgets/floating_action_button.dart';
import 'package:nesscale_task/view/widgets/listItem.dart';

import '../widgets/test_form_fields.dart';

class Items extends StatefulWidget {
  const Items({Key? key}) : super(key: key);

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetItemsBloc>(context).add(GetItemsList());
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
                  title: 'Items',
                  onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage())),
                )
              ],
            ),
          ),
          Positioned(
            top: 0.2 * MediaQuery.of(context).size.height,
            left: 0,
            child: BlocBuilder<GetItemsBloc, GetItemsState>(
              builder: (context, state) {
                return state is ItemsLoadedState
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        child: state.itemsList.length == 0
                            ? Center(
                                child: Text(
                                  'No Items Found',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : ListView.builder(
                                itemCount: state.itemsList.length,
                                itemBuilder: (context, index) {
                                  var itemInfo = state.itemsList[index];
                                  return ListItem(
                                    itemCode: itemInfo['code'],
                                    itemName: itemInfo['name'],
                                    itemPrce: itemInfo['rate'].toString(),
                                    id: itemInfo['id'],
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
        title: 'Add Item',
        onPressed: _addItems,
      ),
    );
  }

  _addItems() {
    final _key = GlobalKey<FormState>();
    TextEditingController _itemName = TextEditingController();
    TextEditingController _itemCode = TextEditingController();
    TextEditingController _itemRate = TextEditingController();
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
                        'Add Item',
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextFormFields(
                        controller: _itemName,
                        hintText: 'Enter Item Name',
                        labelText: 'Item Name'),
                    TextFormFields(
                        controller: _itemCode,
                        hintText: 'Item Code',
                        labelText: 'Code'),
                    TextFormFields(
                        controller: _itemRate,
                        hintText: 'Item Rate',
                        labelText: 'Rate'),
                    CustomButton(
                        title: 'Add Item',
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            DataBaseHelper.createItem(_itemName.text,
                                _itemCode.text, double.parse(_itemRate.text));
                            BlocProvider.of<GetItemsBloc>(context)
                                .add(GetItemsList());
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
