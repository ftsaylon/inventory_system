/* -------------------------------- Packages -------------------------------- */

import 'package:flutter/material.dart';

/* --------------------------------- Screens -------------------------------- */

import '../screens/item_list_screen.dart';
import '../screens/purchase_requisition_list_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
          ListTile(
            // leading: Icon(
            //   Icons.list,
            //   color: Theme.of(context).accentColor,
            // ),
            title: Text(
              'Items Catalog',
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ItemListScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            // leading: Icon(
            //   Icons.list,
            //   color: Theme.of(context).accentColor,
            // ),
            title: Text(
              'Purchase Requisition',
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(PurchaseRequisitionListScreen.routeName);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
