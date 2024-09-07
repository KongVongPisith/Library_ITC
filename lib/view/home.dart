import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:itc_library/widget/appBar.dart';
import 'package:itc_library/widget/drawer_component/drawer.dart';
import 'package:itc_library/widget/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  @override
  Widget build(BuildContext context) {

    String MarkdownContent = """
  # Library of Institute of Technology of Cambodia
  
  ![](resource:assets/2.jpg)

  The Library of Institute of Technology of Cambodia
  this library is a collection of science, technology, engineering,
  mathematic books and has been developed since 1981 to help students
  and researchers and lecturers to do their research activity,
  more than that students allow to use free WIFI with 5G technology.
  
  ---
  
  # Library Website
  
  ![](resource:assets/3-1.png)
  
  The students can use library website
  [bib.itc.edu.kh](http://bib.itc.edu.kh/catalog/opac_css/)
  for getting more information, research link and some e-books resources.
  We update library information everyday such as new room services,
  training course, workshop …etc, so students can get information 
  by the Facebook page of Library(Library of ITC) or group of Facebook.
  On other hand they can learn more on Youtube page too.
  
  ---
  
  #
  # Library Service
  
  ![](resource:assets/5.png)
  
  We allow students to borrow two books per week and two times renewal.
  If students  want  to use our discussion room  services, so we need student ID 
  card for their booking.
  
  ---
  
  # Locker
  
  ![](resource:assets/6.png)
  
  To keep student’s valuable safe,We provide 60 lockers for students, 
  In order to request locker key, all students must have ID Card.
  
  ---
  
  # Training Course
  
  ![](resource:assets/7-1.png)
  
  When new semester is coming, so we set up a library orientation
  course for freshmen students to know how to use library services 
  such as catalog system, request or renewal, booking discussion and 
  self-study& e-learning room.
  
  ---
  
  # Self-Study & E-Learning
  
  ![](resource:assets/8-1.png)
  
   We have provided a comfortable room with 30 computer laptops for
   students to make their self-study 
   or access to the e-learning system. 
   Other hand patrons can request their demonstration presentation.
   
   ---
   
   # Charge Printing and Copying
   
   ![](resource:assets/9.png)
   
   We have reserved two computers for printing and copying services, 
   so students can print documents by their  own self, 
   student need  to pay the cheapest prices when they print or copy. 
   On other hand students can keep their documents on that personal computer too.
  
  ---
  
  # Searching and Working
  
  ![](resource:assets/12.png)
  
  ![](resource:assets/14-1024x768.jpg)
  
  The students can use this computer desktops connected internet for 
  searching and do their exercise and study e-learning online system.
  
  ---
  
  # Discussion & Team Work
   
  ![](resource:assets/13.jpg)
    
  The students can use this computer desktops connected internet for searching 
  and do their exercise and study e-learning online system.
  
  ---
  
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
          appBar: Custom_appbar(context),
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

// Alternative way to adjust img
// ![<img src ="assets/resource:assets/5.png" width="100" height="x"/> ](resource:assets/5.png)