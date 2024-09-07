import 'package:flutter/material.dart';
import 'package:itc_library/model/events_model.dart';
import 'package:itc_library/widget/Detail_appBar.dart';
import 'package:itc_library/widget/theme.dart';

class Event_detail extends StatelessWidget {
  final Events_model events_model;

  Event_detail({required this.events_model});

  @override
  Widget build(BuildContext context) {

    final String background;
    final theme = Theme.of(context);
    if(theme.brightness == Brightness.light){
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
        appBar: JustBack(context),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  events_model.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  'Start at :' + events_model.publishedAt,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodySmall,
                ),

                SizedBox(height: 20,),
                Image.network(events_model.urlToImage),

                SizedBox(height: 20),
                Text(
                  events_model.content,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 20),
                Text(
                  events_model.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
