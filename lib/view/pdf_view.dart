import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import '../widget/Detail_appBar.dart';

class Pdf_view extends StatelessWidget {
  final String pdf;
  Pdf_view({required this.pdf});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JustBack(context),
      body: const PDF(
        pageFling: true,
        pageSnap: true,
        enableSwipe: true,
      ).cachedFromUrl(
        pdf,
        placeholder: (progress) => Center(
          child: CircularProgressIndicator(value: progress,),
        ),
        errorWidget: (error) => Center(
          child: Text('Error loading PDF: $error'),
        ),
      ),
    );
  }
}
