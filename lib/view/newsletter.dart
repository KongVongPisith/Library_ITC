import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:itc_library/model/newsletter_model.dart';
import 'package:itc_library/repo/Newsletter_repo.dart';
import 'package:itc_library/widget/back_appBar.dart';
import 'package:itc_library/widget/drawer_component/drawer.dart';
import 'package:itc_library/widget/theme.dart';
import 'package:path_provider/path_provider.dart';

class Newsletter extends StatefulWidget {
  const Newsletter({super.key});

  @override
  State<Newsletter> createState() => _NewsletterState();
}

class _NewsletterState extends State<Newsletter> {
  List<Newsletters_model> newsletterModel = [];
  Newsletter_repo nr = Newsletter_repo();
  bool _isLoading = true;
  List<Widget> pdfCovers = [];

  @override
  void initState() {
    super.initState();
    getNewsletters();
  }

  Future<Widget?> renderPdfCover(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final filePath = '${tempDir.path}/${url.split('/').last}';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        return Container(
          height: 150,
          child: PDFView(
            filePath: file.path,
            enableSwipe: false,
            swipeHorizontal: false,
            autoSpacing: false,
            pageFling: false,
            defaultPage: 0,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation: false,
          ),
        );
      } else {
        throw Exception('Failed to download PDF');
      }
    } catch (e) {
      print('Error rendering PDF cover: $e');
      return null;
    }
  }

  Future<void> getNewsletters() async {
    try {
      await nr.getNewsletter();
      newsletterModel = nr.newsletter_model;
      for (var model in newsletterModel) {
        final cover = await renderPdfCover(model.file);
        if (cover != null) {
          pdfCovers.add(cover);
        }
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching newsletters: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    final String background = Theme.of(context).brightness == Brightness.light
        ? Custom_theme.lightBackgroundImage
        : Custom_theme.darkBackgroundImage;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(background),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: Back_appBar(context, 'Newsletter'),
        drawer: Drawer_theme(context),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: (itemWidth / itemHeight),
            mainAxisExtent: 300,
          ),
          itemCount: pdfCovers.length,
          itemBuilder: (context, index) {
            return pdfCovers[index];
          },
        ),
      ),
    );
  }
}
