import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class PDFViewerPage extends StatelessWidget {
  final PDFDocument document;
  const PDFViewerPage({Key key, this.document}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: PDFViewer(document: document),
      ),
    );
  }
}
