/* -------------------------------- Packages -------------------------------- */

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/* -------------------------------- Providers ------------------------------- */

import '../providers/purchase_requisition_item.dart';
import '../providers/purchase_requisitions.dart';

/* --------------------------------- Screens -------------------------------- */

import '../screens/item_detail_screen.dart';
import '../screens/edit_item_screen.dart';

/* --------------------------------- Widgets -------------------------------- */

import '../providers/item.dart';
import '../providers/items.dart';

enum ActionOptions {
  Edit,
  Delete,
}

class ItemListTile extends StatelessWidget {
  final requisitionId;
  final purchaseRequisitionItems;
  final addingFromCatalog;

  ItemListTile({
    this.requisitionId,
    this.purchaseRequisitionItems,
    this.addingFromCatalog,
  });

  final pesoFormat = new NumberFormat.currency(
    locale: 'en_PH',
    decimalDigits: 2,
    symbol: '₱',
  );

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context, listen: false);

    return buildSlidable(context, item);
  }

/* -------------------------------------------------------------------------- */
/*                                  Builders                                  */
/* -------------------------------------------------------------------------- */

  Future<bool> buildShowDialog(BuildContext context, Item item) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Are you sure you want to delete ${item.name}?"),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                try {
                  await Provider.of<Items>(context, listen: false)
                      .deleteItem(item.id);
                  Navigator.of(context).pop();
                } catch (e) {}
              },
            ),
          ],
        );
      },
    );
  }
/* -------------------------------------------------------------------------- */

  ListTile buildListTile(BuildContext context, Item item) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(
          ItemDetailScreen.routeName,
          arguments: item.id,
        );
      },
      title: Text(item.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("Qty: ${item.quantity} - "),
              Text("Cost: " + pesoFormat.format(double.parse(item.cost))),
            ],
          ),
          Text(
            "Total Amount: " +
                pesoFormat.format(item.quantity * double.parse(item.cost)),
          ),
        ],
      ),
      isThreeLine: true,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(item.imageUrl),
      ),
      trailing: (requisitionId != null || addingFromCatalog) 
          ? IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                final newPurchaseRequisitionItem = PurchaseRequisitionItem(
                  id: null,
                  itemId: item.id,
                  sku: item.sku,
                  name: item.name,
                  quantity: item.quantity,
                  unitType: item.unitType,
                  estimatedPrice: item.price,
                  preferredSupplier: item.preferredSupplier,
                  size: item.size,
                  comments: item.comments,
                  isPreApproved: false,
                );

                if (requisitionId != null) {
                  Provider.of<PurchaseRequisitions>(context, listen: false)
                      .findById(requisitionId)
                      .purchaseRequisitionItems
                      .addItem(newPurchaseRequisitionItem);
                } else {
                  print(requisitionId);
                  print(addingFromCatalog);
                  print(purchaseRequisitionItems);
                  purchaseRequisitionItems.addItem(newPurchaseRequisitionItem);
                }
              },
            )
          : buildPopupMenuButton(context, item),
    );
  }

/* -------------------------------------------------------------------------- */

  PopupMenuButton<ActionOptions> buildPopupMenuButton(
      BuildContext context, Item item) {
    return PopupMenuButton(
      onSelected: (ActionOptions selectedValue) {
        if (selectedValue == ActionOptions.Edit) {
          Navigator.of(context)
              .pushNamed(EditItemScreen.routeName, arguments: item.id);
        } else {
          buildShowDialog(context, item);
        }
      },
      icon: Icon(
        Icons.more_vert,
      ),
      itemBuilder: (_) => [
        PopupMenuItem(
          child: Text('Edit'),
          value: ActionOptions.Edit,
        ),
        PopupMenuItem(
          child: Text('Delete'),
          value: ActionOptions.Delete,
        ),
      ],
    );
  }

/* -------------------------------------------------------------------------- */

  Widget buildSlidable(BuildContext context, Item item) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: buildListTile(context, item),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.green,
          icon: Icons.edit,
          onTap: () => {
            Navigator.of(context).pushNamed(
              EditItemScreen.routeName,
              arguments: item.id,
            )
          },
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Theme.of(context).errorColor,
          icon: Icons.delete,
          onTap: () => buildShowDialog(context, item),
        ),
      ],
    );
  }
}
