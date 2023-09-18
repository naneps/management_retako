import 'dart:io';

import 'package:flutter/material.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFScreen extends StatefulWidget {
  final String? path;
  final String? title;
  final bool? hasAppBar;

  const PDFScreen({
    Key? key,
    this.path,
    this.title,
    this.hasAppBar = true,
  }) : super(key: key);

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.hasAppBar!
          ? AppBar(
              title: Text(
                widget.title ?? "PDF",
                style: const TextStyle(color: Colors.black),
              ),
              iconTheme: const IconThemeData(color: Colors.black),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {},
                ),
              ],
            )
          : null,
      body: SafeArea(
        child: RoundedContainer(
          child: _buildPDFViewer(),
        ),
      ),
    );
  }

  Widget _buildPDFViewer() {
    if (widget.path == null) {
      return const Center(
        child: Text("No PDF specified"),
      );
    }

    if (widget.path!.startsWith('http') || widget.path!.startsWith('https')) {
      // Network URL
      return SfPdfViewer.network(
        widget.path!,
        onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
          // Handle load failure
          print(details.error);
        },
        onDocumentLoaded: (PdfDocumentLoadedDetails details) {
          // Handle document load success
          print(details.document);
        },
        enableDoubleTapZooming: true,
        enableTextSelection: true,
        enableDocumentLinkAnnotation: true,
      );
    } else if (widget.path!.startsWith('assets')) {
      // Asset PDF
      return SfPdfViewer.asset(
        widget.path!,
        onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
          // Handle load failure
          print(details.error);
        },
        onDocumentLoaded: (PdfDocumentLoadedDetails details) {
          // Handle document load success
          print(details.document);
        },
        enableDoubleTapZooming: true,
        enableTextSelection: true,
        enableDocumentLinkAnnotation: true,
      );
    } else {
      // Local file path
      return SfPdfViewer.file(
        File(widget.path!),
        onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
          // Handle load failure
          print(details.error);
        },
        onDocumentLoaded: (PdfDocumentLoadedDetails details) {
          // Handle document load success
          print(details.document);
        },
        enableDoubleTapZooming: true,
        enableTextSelection: true,
        enableDocumentLinkAnnotation: true,
      );
    }
  }
}
