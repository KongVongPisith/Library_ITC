import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:itc_library/widget/appBar.dart';
import 'package:itc_library/widget/back_appBar.dart';
import 'package:itc_library/widget/drawer_component/drawer.dart';
import 'package:itc_library/widget/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {

    String MarkdownContent = """
   ## 1. Introduction
   
   At ITC Library,
   we are committed to protecting your privacy 
   and ensuring the security of your personal information.
   This Privacy Policy explains how we collect,
   use, and safeguard your data when you use our services.
   
   ## 2. Information We Collect
   
   Our e-library app is designed to be user-friendly and does not require user authentication.
   As a result, we do not collect any personal information such as names,
    email addresses, or contact information.
   
   ## 3. Sharing Your Information
   
   We do not sell, trade, or rent your personal information
   to third parties. However, we may share your data with trusted 
   partners who assist us in operating our website and services, 
   provided they agree to keep this information confidential.
   
   ## 4. Data Security
   
   We take the security of your data seriously and implement appropriate
   measures to protect it. The data collected is anonymized and stored securely,
   ensuring that it cannot be traced back to any individual user.
   
   ## 5. Changes to This Privacy Policy
   
   We may update this Privacy Policy from time to time. Any changes will be posted within the app,
   and the date at the top of the policy will reflect the latest revision.
    
    """;

    final theme = Theme.of(context);
    String backgroundImage;
    if (theme.backgroundColor == Colors.white) {
      backgroundImage = Custom_theme.lightBackgroundImage;
    } else {
      backgroundImage = Custom_theme.darkBackgroundImage;
    }
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: Back_appBar(context, 'Privacy'),
          drawer: Drawer_theme(context),
          body: SafeArea(
            child: Markdown(
              data: MarkdownContent,
              styleSheet: MarkdownStyleSheet(
                h1Align: WrapAlignment.center,
                h1: Theme.of(context).textTheme.titleLarge,
                p: Theme.of(context).textTheme.bodyMedium,
                a: TextStyle(
                  fontFamily: 'Bitter_regular',
                  fontSize: 15,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
              imageDirectory: 'assets',
              selectable: true,
              imageBuilder: (uri, title, alt) {
                return Image.asset(
                  width: double.infinity,
                  uri.path,
                  fit: BoxFit.cover,
                );
              },
              onTapLink: (text, url, title){
                launchUrl(Uri.parse(url!)); /*For url_launcher 6.1.0 and higher*/
                // launch(url);  /*For url_launcher 6.0.20 and lower*/
              },
            ),

          )),
    );
  }
}
