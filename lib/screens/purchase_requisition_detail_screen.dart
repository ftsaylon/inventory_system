/* -------------------------------- Packages -------------------------------- */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

/* -------------------------------- Providers ------------------------------- */

import '../providers/purchase_requisitions.dart';
import '../providers/purchase_requisition.dart';

/* --------------------------------- Screens -------------------------------- */

import 'edit_purchase_requisition_screen.dart';

/* --------------------------------- Widgets -------------------------------- */

import '../widgets/purchase_requisition_item_list_tile.dart';
import 'purchase_requisition_item_list_screen.dart';

class PurchaseRequisitionDetailScreen extends StatelessWidget {
  final pesoFormat = NumberFormat.currency(
    locale: 'en_PH',
    decimalDigits: 2,
    symbol: '₱',
  );
  static const routeName = 'purchase-requisition-detail';

  @override
  Widget build(BuildContext context) {
    final requisitionId = ModalRoute.of(context).settings.arguments as String;
    final loadedRequisition =
        Provider.of<PurchaseRequisitions>(context, listen: false)
            .findById(requisitionId);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).pushNamed(
                EditPurchaseRequisitionScreen.routeName,
                arguments: requisitionId),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('ID'),
              subtitle: Text(
                loadedRequisition.id.toString(),
                style: Theme.of(context).textTheme.title,
              ),
              dense: true,
            ),
            ListTile(
              title: Text('Location'),
              subtitle: Text(
                loadedRequisition.location.toString(),
                style: Theme.of(context).textTheme.title,
              ),
              dense: true,
            ),
            ListTile(
              title: Text('Department'),
              subtitle: Text(
                loadedRequisition.department.toString(),
                style: Theme.of(context).textTheme.title,
              ),
              dense: true,
            ),
            ListTile(
              title: Text('Project'),
              subtitle: Text(
                loadedRequisition.project.toString(),
                style: Theme.of(context).textTheme.title,
              ),
              dense: true,
            ),
            ListTile(
              title: Text('Total Estimated Cost'),
              subtitle: Text(
                "${pesoFormat.format(double.parse(loadedRequisition.totalEstimatedCost))}",
                style: Theme.of(context).textTheme.title,
              ),
              dense: true,
            ),
            ListTile(
              title: Text('Requested By'),
              subtitle: Text(
                loadedRequisition.requestedBy.toString(),
                style: Theme.of(context).textTheme.title,
              ),
              dense: true,
            ),
            ListTile(
              title: Text('Next Approver'),
              subtitle: Text(
                loadedRequisition.nextApprover.toString(),
                style: Theme.of(context).textTheme.title,
              ),
              dense: true,
            ),
            ListTile(
              title: Text('Status'),
              subtitle: Text(
                loadedRequisition.status.toString(),
                style: Theme.of(context).textTheme.title,
              ),
              dense: true,
            ),
            ListTile(
              title: Text('Date Required'),
              subtitle: Text(
                DateFormat.yMEd()
                    .add_jms()
                    .format(loadedRequisition.dateRequired),
                style: Theme.of(context).textTheme.body2,
              ),
              dense: true,
            ),
            ListTile(
              title: Text('Date Submitted'),
              subtitle: Text(
                DateFormat.yMEd()
                    .add_jms()
                    .format(loadedRequisition.dateSubmitted),
                style: Theme.of(context).textTheme.body2,
              ),
              dense: true,
            ),
            ListTile(
              title: Text('Date Modified'),
              subtitle: Text(
                DateFormat.yMEd()
                    .add_jms()
                    .format(loadedRequisition.dateModified),
                style: Theme.of(context).textTheme.body2,
              ),
              dense: true,
            ),
            RaisedButton(
              child: Text("See Items"),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(PurchaseRequisitionItemListScreen.routeName, arguments: loadedRequisition.id);
              },
            )
          ],
        ),
      ),
    );
  }
}
