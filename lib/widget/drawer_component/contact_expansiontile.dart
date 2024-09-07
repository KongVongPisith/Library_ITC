import 'package:flutter/material.dart';
import 'package:itc_library/constant/colorSet.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact_list{
  final String title;
  final IconData icon;
  final String uri;
  const Contact_list({required this.title, required this.icon, required this.uri});
}

class Contact_item{
  static final phone = Contact_list(title: 'Telephone',icon: Icons.phone, uri: 'tel:023880370');
  static final email = Contact_list(title: 'Email',icon: Icons.email_outlined,uri: 'mailto:info@itc.edu.kh');
  static final web = Contact_list(title: 'Website',icon: Icons.web_asset, uri: 'https://itc.edu.kh/library/');
  static final facebook = Contact_list(title: 'Facebook',icon: Icons.facebook_rounded,uri: 'https://www.facebook.com/libraryitc?mibextid=ZbWKwL');

  static final List<Contact_list> list = [
    phone,
    email,
    web,
    facebook
  ];
}

ExpansionTile Contact_expansionTile(BuildContext context){
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
          'Contact',
          style: Theme.of(context).primaryTextTheme.titleMedium,
        ),
      ),
    children: <Widget>[
      ...Contact_item.list.asMap().entries.map((e) =>
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ListTile(
              title: Row(
                children: <Widget>[
                  Icon(
                    e.value.icon,
                    size: 20,
                    color: Icon_color,
                  ),
                  SizedBox(width: 10,),
                  Text(
                    e.value.title,
                    style: Theme.of(context).primaryTextTheme.titleSmall,
                  ),
                ],
              ),
              onTap: (){
                launchUrl(Uri.parse(e.value.uri));
              },
            ),
          ),
      ),
    ],
  );
}