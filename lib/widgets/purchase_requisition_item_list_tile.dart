/* -------------------------------- Packages -------------------------------- */

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/* -------------------------------- Providers ------------------------------- */

import '../providers/purchase_requisitions.dart';
import '../providers/purchase_requisition_item.dart';

/* --------------------------------- Screens -------------------------------- */

/* --------------------------------- Widgets -------------------------------- */

enum ActionOptions {
  Edit,
  Delete,
}

class PurchaseRequisitionItemListTile extends StatelessWidget {
  final requisitionId;

  PurchaseRequisitionItemListTile({this.requisitionId});

  final pesoFormat = new NumberFormat.currency(
    locale: 'en_PH',
    decimalDigits: 2,
    symbol: '₱',
  );

  @override
  Widget build(BuildContext context) {
    final requisitionItem =
        Provider.of<PurchaseRequisitionItem>(context, listen: false);
    return buildSlidable(context, requisitionItem);
  }

/* -------------------------------------------------------------------------- */
/*                                  Builders                                  */
/* -------------------------------------------------------------------------- */

  Future<bool> buildShowDialog(
      BuildContext context, PurchaseRequisitionItem requisitionItem) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content:
              Text("Are you sure you want to delete ${requisitionItem.name}?"),
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
                  await Provider.of<PurchaseRequisitions>(
                    context,
                  ).deleteRequisitionItem(
                    requisitionId,
                    requisitionItem.itemId,
                  );
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

  ListTile buildListTile(
      BuildContext context, PurchaseRequisitionItem requisitionItem) {
    return ListTile(
      onTap: () {},
      title: Text(requisitionItem.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("Qty: ${requisitionItem.quantity} - "),
              Text("Estimated Price: " +
                  pesoFormat
                      .format(double.parse(requisitionItem.estimatedPrice))),
            ],
          ),
          Text(
            "Total Amount: " +
                pesoFormat.format(requisitionItem.quantity *
                    double.parse(requisitionItem.estimatedPrice)),
          ),
        ],
      ),
      isThreeLine: true,
      // leading: CircleAvatar(
      //   backgroundImage: NetworkImage(requisitionItem.imageUrl),
      // ),
      trailing: buildPopupMenuButton(context, requisitionItem),
    );
  }

/* -------------------------------------------------------------------------- */

  PopupMenuButton<ActionOptions> buildPopupMenuButton(
      BuildContext context, PurchaseRequisitionItem requisitionItem) {
    return PopupMenuButton(
      onSelected: (ActionOptions selectedValue) {
        if (selectedValue == ActionOptions.Edit) {
          // Navigator.of(context).pushNamed(EditItemScreen.routeName,
          //     arguments: requisitionItem.id);
        } else {
          buildShowDialog(context, requisitionItem);
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

  Widget buildSlidable(
      BuildContext context, PurchaseRequisitionItem requisitionItem) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: buildListTile(context, requisitionItem),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.green,
          icon: Icons.edit,
          onTap: () => {
            // Navigator.of(context).pushNamed(
            //   EditItemScreen.routeName,
            //   arguments: requisitionItem.id,
            // )
          },
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Theme.of(context).errorColor,
          icon: Icons.delete,
          onTap: () => buildShowDialog(context, requisitionItem),
        ),
      ],
    );
  }
}
