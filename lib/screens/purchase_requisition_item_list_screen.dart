/* -------------------------------- Packages -------------------------------- */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/* -------------------------------- Providers ------------------------------- */

import '../providers/purchase_requisitions.dart';

/* --------------------------------- Screens -------------------------------- */

/* --------------------------------- Widgets -------------------------------- */

import '../widgets/purchase_requisition_item_list_tile.dart';
import 'item_list_screen.dart';

class PurchaseRequisitionItemListScreen extends StatelessWidget {
  const PurchaseRequisitionItemListScreen({Key key}) : super(key: key);

  static const routeName = '/purchase-requisition-item-list';

  @override
  Widget build(BuildContext context) {
    final requisitionId = ModalRoute.of(context).settings.arguments as String;
    final loadedRequisition =
        Provider.of<PurchaseRequisitions>(context).findById(requisitionId);

    final loadedRequisitionItems =
        loadedRequisition.purchaseRequisitionItems.items;

    return Scaffold(
      appBar: AppBar(
        title: Text("Items in $requisitionId"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => {
              Navigator.of(context).pushNamed(
                ItemListScreen.routeName,
                arguments: {'requisitionId': requisitionId},
              )
            },
          ),
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: loadedRequisitionItems.length,
          itemBuilder: (BuildContext context, int index) {
            return ChangeNotifierProvider.value(
              value: loadedRequisitionItems.values.toList()[index],
              child: PurchaseRequisitionItemListTile(
                requisitionId: requisitionId,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            ItemListScreen.routeName,
            arguments: {'requisitionId': requisitionId},
          );
        },
        tooltip: 'Add New',
        child: Icon(Icons.add),
      ), //
    );
  }
}
