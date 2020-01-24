/* -------------------------------- Packages -------------------------------- */

import 'package:flutter/material.dart';
import 'package:inventory_system/providers/purchase_requisitions.dart';
import 'package:provider/provider.dart';

/* -------------------------------- Providers ------------------------------- */

import '../providers/items.dart';

/* --------------------------------- Screens -------------------------------- */

import '../screens/edit_item_screen.dart';

/* --------------------------------- Widgets -------------------------------- */

import '../widgets/item_list_tile.dart';
import '../widgets/app_drawer.dart';

class ItemListScreen extends StatelessWidget {
  static const String routeName = "/items";

  @override
  Widget build(BuildContext context) {
    final loadedItems = Provider.of<Items>(context);

/* -------- Checks if this screen is called from Purchase Requisition ------- */
    var requisitionId;
    if (ModalRoute.of(context).settings.arguments != null) {
      requisitionId =
          (ModalRoute.of(context).settings.arguments as Map)['requisitionId'];
    }
    final hasRequisitionId = requisitionId != null;
/* -------------------------------------------------------------------------- */

    return Scaffold(
      appBar: AppBar(
        title: hasRequisitionId ? Text(requisitionId) : Text("Items Catalog"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditItemScreen.routeName);
            },
          ),
        ],
      ),
      drawer: hasRequisitionId ? null : AppDrawer(),
      body: buildContainer(loadedItems, requisitionId),
      floatingActionButton: hasRequisitionId == false
          ? FloatingActionButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(EditItemScreen.routeName),
              tooltip: 'Add New',
              child: Icon(Icons.add),
            )
          : FloatingActionButton(
              onPressed: () => addFromCatalog(context, requisitionId),
              tooltip: 'Save',
              child: Icon(Icons.save),
            ), //
    );
  }

/* -------------------------------------------------------------------------- */
/*                                  Builders                                  */
/* -------------------------------------------------------------------------- */

  Container buildContainer(Items loadedItems, String requisitionId) {
    return Container(
      child: ListView.builder(
        // separatorBuilder: (context, index) => Divider(),
        itemCount: loadedItems.items.length,
        itemBuilder: (BuildContext context, int index) {
          return ChangeNotifierProvider.value(
            value: loadedItems.items[index],
            child: ItemListTile(requisitionId: requisitionId),
          );
        },
      ),
    );
  }

/* -------------------------------------------------------------------------- */
/*                                   Helpers                                  */
/* -------------------------------------------------------------------------- */

  Future<void> addFromCatalog(
      BuildContext context, String requisitionId) async {
    final loadedRequisition =
        Provider.of<PurchaseRequisitions>(context).findById(requisitionId);
    await Provider.of<PurchaseRequisitions>(context)
        .updateRequisition(requisitionId, loadedRequisition);
    Navigator.of(context).pop();
  }
}
