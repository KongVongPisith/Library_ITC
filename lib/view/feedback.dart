import 'dart:math';
import 'package:flutter/material.dart';
import 'package:itc_library/constant/colorSet.dart';
import 'package:itc_library/widget/back_appBar.dart';
import 'package:itc_library/widget/drawer_component/drawer.dart';
import 'package:itc_library/widget/theme.dart';
class Feedback_page extends StatefulWidget {
  const Feedback_page({super.key});

  @override
  State<Feedback_page> createState() => _Feedback_pageState();
}

class _Feedback_pageState extends State<Feedback_page> {
  @override
  Widget build(BuildContext context) {

    final String background;
    final theme = Theme.of(context);
    if(theme.backgroundColor==Colors.white){
      background = Custom_theme.lightBackgroundImage;
    }else{
      background = Custom_theme.darkBackgroundImage;
    }
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(background),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: Back_appBar(context, 'Feedback'),
        drawer: Drawer_theme(context),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
              ),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.close_outlined ,
                          color: Title_color,
                          size: 22,
                        ),
                        onPressed: () {
                        },
                      ),
                      Text(
                        'New Message',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                      Spacer(),
                      Transform.rotate(
                        angle: 90*pi/180,
                        child: IconButton(
                          icon: Icon(
                            Icons.attach_file,
                            size: 30,
                            color: Title_color,
                          ),
                          onPressed: () {

                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send,color: Colors.grey,size: 25,),
                        onPressed: () {

                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Write your feedback here',
                        hintStyle: TextStyle(
                          fontFamily: 'Bitter_regular',
                          fontSize: 15,
                          textBaseline: TextBaseline.ideographic,
                        ),
                        // labelText: 'Write your feedback here',
                        border: InputBorder.none,
                      ),
                      maxLines: 7,
                      style: Theme.of(context).primaryTextTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
