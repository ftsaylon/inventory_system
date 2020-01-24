/* -------------------------------- Packages -------------------------------- */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/* -------------------------------- Providers ------------------------------- */

import '../providers/purchase_requisitions.dart';

/* --------------------------------- Screens -------------------------------- */

import '../screens/edit_purchase_requisition_screen.dart';

/* --------------------------------- Widgets -------------------------------- */

import '../widgets/purchase_requisition_list_tile.dart';
import '../widgets/app_drawer.dart';

class PurchaseRequisitionListScreen extends StatelessWidget {
  const PurchaseRequisitionListScreen({Key key}) : super(key: key);

  static const routeName = '/purchase-requisition-list';

  @override
    Widget build(BuildContext context) {
    final loadedRequisitions = Provider.of<PurchaseRequisitions>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Purchase Requisitions"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed(
              EditPurchaseRequisitionScreen.routeName,
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Container(
        child: ListView.builder(
          // separatorBuilder: (context, index) => Divider(),
          itemCount: loadedRequisitions.requisitions.length,
          itemBuilder: (BuildContext context, int index) {
            return ChangeNotifierProvider.value(
              value: loadedRequisitions.requisitions[index],
              child: PurchaseRequisitionListTile(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(
          EditPurchaseRequisitionScreen.routeName,
        ),
        tooltip: 'Add New',
        child: Icon(Icons.add),
      ), //
    );
  }
}
