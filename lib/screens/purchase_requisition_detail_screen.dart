/* -------------------------------- Packages -------------------------------- */

import 'dart:io';
// import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart'
    as pdfViewer;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:path_provider/path_provider.dart';

/* -------------------------------- Providers ------------------------------- */

import '../providers/purchase_requisitions.dart';
import '../providers/purchase_requisition.dart';

/* --------------------------------- Screens -------------------------------- */

import '../screens/edit_purchase_requisition_screen.dart';
import '../screens/pdf_viewer.dart';

/* --------------------------------- Widgets -------------------------------- */

import 'purchase_requisition_item_list_screen.dart';

class PurchaseRequisitionDetailScreen extends StatefulWidget {
  static const routeName = 'purchase-requisition-detail';

  @override
  _PurchaseRequisitionDetailScreenState createState() =>
      _PurchaseRequisitionDetailScreenState();
}

class _PurchaseRequisitionDetailScreenState
    extends State<PurchaseRequisitionDetailScreen> {
  final pesoFormat = NumberFormat.currency(
    locale: 'en_PH',
    decimalDigits: 2,
    symbol: '₱',
  );

  pdfLib.Document pdf;

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
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () {
              _generatePDF(context, loadedRequisition);
            },
          ),
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
                Navigator.of(context).pushNamed(
                    PurchaseRequisitionItemListScreen.routeName,
                    arguments: loadedRequisition.id);
              },
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    child: Text("Create PDF"),
                    onPressed: () async {
                      await _generatePDF(context, loadedRequisition);
                    },
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    child: Text("View PDF"),
                    onPressed: () async {
                      _viewPDF(
                        context,
                        await pdfViewer.PDFDocument.fromFile(
                          File(
                            await _getPDFFilePath(loadedRequisition.id),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    child: Text('Save PDF'),
                    onPressed: () async {
                      await _printPDF(loadedRequisition.id);
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

/* -------------------------------------------------------------------------- */

  Future<void> _printPDF(String requisitionId) async {
    await Printing.sharePdf(
      bytes: pdf.save(),
      filename: 'PR-$requisitionId-${DateTime.now()}.pdf',
    );
  }

/* -------------------------------------------------------------------------- */

  List<List<String>> _getData(PurchaseRequisition requisition) {
    return [
      ...requisition.purchaseRequisitionItems.items.values.map(
        (item) => [
          item.name ?? '',
          item.preferredSupplier ?? '',
          item.sku ?? '',
          item.quantity.toString() ?? '',
          item.unitType ?? '',
          item.estimatedPrice ?? '',
          item.size ?? '',
          item.isPreApproved.toString() ?? '',
          item.comments ?? '',
        ],
      )
    ];
  }

/* -------------------------------------------------------------------------- */

  _generatePDF(BuildContext context, PurchaseRequisition data) async {
    pdf = pdfLib.Document(deflate: zlib.encode);

    pdf.addPage(
      pdfLib.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pdfLib.Text('Purchase Requisition ID: ${data.id.toString()}',
              style: pdfLib.TextStyle(fontWeight: pdfLib.FontWeight.bold)),
          pdfLib.Text('Location: ${data.location}'),
          pdfLib.Text('Department: ${data.department}'),
          pdfLib.Text('Project: ${data.project}'),
          pdfLib.Text('Total Estimated Cost: "${data.totalEstimatedCost}"'),
          pdfLib.Text('Requested By: ${data.requestedBy}'),
          pdfLib.Text('Approver: ${data.nextApprover}'),
          pdfLib.Text('Status: ${data.status}'),
          pdfLib.Text(
              'Date Required: ${DateFormat.yMEd().add_jms().format(data.dateRequired)}'),
          pdfLib.Text(
              'Date Submitted: ${DateFormat.yMEd().add_jms().format(data.dateSubmitted)}'),
          pdfLib.Text(
              'Date Modified: ${DateFormat.yMEd().add_jms().format(data.dateModified)}'),
          pdfLib.Table.fromTextArray(
            context: context,
            data: [
              [
                'Name',
                'Preferred Supplier',
                'SKU',
                'Quantity',
                'Unit Type',
                'Estimated Price',
                'Size',
                'Pre-Approved',
                'Comments',
              ],
              ..._getData(data)
            ],
          ),
        ],
      ),
    );
    // html.window.open('http://www.pdf995.com/samples/pdf.pdf', "PDF");

    final File file = File(await _getPDFFilePath(data.id));
    await file.writeAsBytes(pdf.save());
  }

  _viewPDF(BuildContext context, pdfViewer.PDFDocument document) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PDFViewerPage(document: document),
      ),
    );
  }

/* -------------------------------------------------------------------------- */

  Future<String> _getPDFFilePath(String id) async {
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/PR-$id.pdf';
    print(path);
    return path;
  }

/* -------------------------------------------------------------------------- */

}
