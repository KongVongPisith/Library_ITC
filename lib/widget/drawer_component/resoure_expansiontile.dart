import 'package:flutter/material.dart';
import 'package:itc_library/view/book_category.dart';
import 'package:itc_library/view/journal_category.dart';
import 'package:itc_library/view/newsletter.dart';
import 'package:itc_library/view/thesis.dart';

class Resource_drawer_list {
  final String title;

  const Resource_drawer_list({required this.title});
}

class Resource_drawer_item {
  static final book = Resource_drawer_list(title: 'Book');
  static final newspaper = Resource_drawer_list(title: 'Newspapers');
  static final journal = Resource_drawer_list(title: 'Journal');
  static final thesis = Resource_drawer_list(title: 'Thesis');

  static final List<Resource_drawer_list> list = [
    book,
    newspaper,
    journal,
    thesis
  ];
}

ExpansionTile Resource_ExpansionTile(BuildContext context) {
  final theme = Theme.of(context);
  bool isDark = true;
  if(theme.brightness==Brightness.light){
    isDark = true;
  }else{
    isDark=false;
  }
  return ExpansionTile(
    // collapsedShape: RoundedRectangleBorder(
    //   side: BorderSide.none
    // ),
    backgroundColor: isDark?Colors.black12:Colors.white30,
    shape: RoundedRectangleBorder(side: BorderSide.none),
    title: Container(
      child: Text(
        'Resource',
        style: Theme.of(context).primaryTextTheme.titleMedium,
      ),
    ),
    children: <Widget>[
      ...Resource_drawer_item.list.asMap().entries.map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                title: Text(
                  e.value.title,
                  style: Theme.of(context).primaryTextTheme.titleSmall,
                ),
                onTap: () {
                  if (e.value == Resource_drawer_item.book) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Book_category()));
                  }else if(e.value == Resource_drawer_item.journal){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context)=>Journal()));
                  }else if(e.value == Resource_drawer_item.newspaper){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Newsletter()));
                  }else if(e.value==Resource_drawer_item.thesis){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context)=>Thesis_category()));
                  }
                },
              ),
            ),
          ),
    ],
  );
}
