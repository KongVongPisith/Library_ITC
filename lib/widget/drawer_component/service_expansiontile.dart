import 'package:flutter/material.dart';
import 'package:itc_library/constant/colorSet.dart';
import 'package:itc_library/view/privacy.dart';
import 'package:itc_library/view/setting.dart';

import '../../view/feedback.dart';

class Service_drawer_list{
  final String title;
  final IconData icon;
  const Service_drawer_list({required this.title, required this.icon});
}

class Service_drawer_item{
  static const setting = Service_drawer_list(title: 'Setting', icon: Icons.settings);
  static const private= Service_drawer_list(title: 'Privacy', icon: Icons.privacy_tip);
  static const feedback = Service_drawer_list(title: 'Feedback', icon: Icons.feedback);
  static final List<Service_drawer_list> list = [
    setting,
    private,
    feedback
  ];
}

ExpansionTile Service_ExpansionTile(BuildContext context){
  final theme = Theme.of(context);
  bool isDark = true;
  if(theme.brightness==Brightness.light){
    isDark = true;
  }else{
    isDark=false;
  }
  return ExpansionTile(
    backgroundColor: isDark?Colors.black12:Colors.white30,
    shape: RoundedRectangleBorder(
        side: BorderSide.none
    ),
    title: Container(
      child: Text(
        'Service',
        style: Theme.of(context).primaryTextTheme.titleMedium,
      ),
    ),
    children: [
      ...Service_drawer_item.list.asMap().entries.map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ListTile(
                        title: Row(
              children: <Widget>[
                Icon(
                  e.value.icon,
                  size: 20,
                  color: Icon_color,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  e.value.title,
                  style: Theme.of(context).primaryTextTheme.titleSmall,
                ),
              ],
                        ),
                        onTap: () {
              if (e.value == Service_drawer_item.feedback) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Feedback_page()));
              } else if (e.value == Service_drawer_item.setting){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Setting()));
              }else if (e.value==Service_drawer_item.private){
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context)=> Privacy()));
              }
                        },
                      ),
            ),
      ),
    ],
  );
}