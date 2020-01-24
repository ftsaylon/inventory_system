/* -------------------------------- Packages -------------------------------- */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/* --------------------------------- Screens -------------------------------- */

import '../screens/edit_purchase_requisition_screen.dart';
import '../screens/purchase_requisition_detail_screen.dart';

/* --------------------------------- Widgets -------------------------------- */

import '../providers/purchase_requisition.dart';
import '../providers/purchase_requisitions.dart';

enum ActionOptions {
  Edit,
  Delete,
}

class PurchaseRequisitionListTile extends StatelessWidget {
  final pesoFormat = new NumberFormat.currency(
    locale: 'en_PH',
    decimalDigits: 2,
    symbol: '₱',
  );

  @override
  Widget build(BuildContext context) {
    final requisition =
        Provider.of<PurchaseRequisition>(context, listen: false);
    return buildSlidable(context, requisition);
  }

/* -------------------------------------------------------------------------- */
/*                                  Builders                                  */
/* -------------------------------------------------------------------------- */

  Future<bool> buildShowDialog(
      BuildContext context, PurchaseRequisition requisition) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Are you sure you want to delete ${requisition.id}?"),
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
                  await Provider.of<PurchaseRequisitions>(context,
                          listen: false)
                      .deleteRequisition(requisition.id);
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
      BuildContext context, PurchaseRequisition requisition) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(
          PurchaseRequisitionDetailScreen.routeName,
          arguments: requisition.id,
        );
      },
      title: Text(requisition.id),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("${requisition.requestedBy}, ${requisition.department}"),
          Text(DateFormat.yMEd().add_jms().format(requisition.dateSubmitted)),
          Text(
              "${pesoFormat.format(double.parse(requisition.totalEstimatedCost))}"),
        ],
      ),
      isThreeLine: true,
      // leading:
      trailing: buildPopupMenuButton(context, requisition),
    );
  }

/* -------------------------------------------------------------------------- */

  PopupMenuButton<ActionOptions> buildPopupMenuButton(
      BuildContext context, PurchaseRequisition requisition) {
    return PopupMenuButton(
      onSelected: (ActionOptions selectedValue) {
        if (selectedValue == ActionOptions.Edit) {
          Navigator.of(context).pushNamed(
            EditPurchaseRequisitionScreen.routeName,
            arguments: requisition.id,
          );
        } else {
          buildShowDialog(context, requisition);
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

  Widget buildSlidable(BuildContext context, PurchaseRequisition requisition) {
    return Slidable(
      enabled: true,
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: buildListTile(context, requisition),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.green,
          icon: Icons.edit,
          onTap: () => {
            Navigator.of(context).pushNamed(
              EditPurchaseRequisitionScreen.routeName,
              arguments: requisition.id,
            )
          },
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Theme.of(context).errorColor,
          icon: Icons.delete,
          onTap: () => buildShowDialog(context, requisition),
        ),
      ],
    );
  }
}
