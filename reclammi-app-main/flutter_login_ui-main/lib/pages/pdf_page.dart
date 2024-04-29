import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart'as pw;

import '../utils/saveAsfile.dart';

class pdfpage extends StatefulWidget {
  final  complaint;
  const pdfpage({required this.complaint});

  @override
  State<pdfpage> createState() => _pdfpageState();
}

class _pdfpageState extends State<pdfpage> {
  PrintingInfo? printinginfo;

  @override
  void initState()  {
    super.initState();
    _init();
  }
  Future<void>_init()async{
    final info=await Printing.info();
    setState(() {
      printinginfo=info;
    });
  }
  @override
  Widget build(BuildContext context) {
    pw.RichText.debug=true;
    final actions=<PdfPreviewAction>[
      if(!kIsWeb)
        const PdfPreviewAction(icon: Icon(Icons.save),onPressed: saveAsFile,)
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 4,
        title: Text('PDF'),
      ),
      body: PdfPreview(
        maxPageWidth:700,
        actions:actions,
        onPrinted:showPrintedToast,
        onShared:showSharedToast,
        build: (format) => generatePdf(format, widget.complaint),
      ),
    );
  }
}
