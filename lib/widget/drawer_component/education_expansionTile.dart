import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Education_list {
  final String department;
  final String imagePath;
  final String uri;
  const Education_list({
    required this.department,
    required this.imagePath,
    required this.uri
  });
}

class Education_item {
  static const first =
      Education_list(
          department: ' Department of Electrical and Energy Engineering',
          imagePath: 'assets/mf84e-removebg-preview.png',
        uri: 'https://gee.itc.edu.kh/academics/index.html'
      );
  static const second =
      Education_list(
          department: ' Department of Architectural Engineering',
          imagePath: 'assets/mf84e-removebg-preview.png',
        uri: 'https://gci.itc.edu.kh/',
      );
  static const third =
      Education_list(
          department: ' Department of Industrial and Mechanical Engineering',
          imagePath: 'assets/mf84e-removebg-preview.png',
        uri: 'https://gim.itc.edu.kh/'
      );
  static const four = Education_list(
      department: ' Department of Information and Communication Engineering',
      imagePath: 'assets/mf84e-removebg-preview.png',
    uri: 'https://gic.itc.edu.kh/'
  );
  static const five = Education_list(
      department: ' Department of Civil Engineering',
      imagePath: 'assets/mf84e-removebg-preview.png',
      uri: 'https://gci.itc.edu.kh/'
  );
  static const six = Education_list(
      department: ' Department of Hydrology and Water Resources Engineering',
      imagePath: 'assets/mf84e-removebg-preview.png',
      uri: 'https://itc.edu.kh/home-hre/'
  );
  static const seven = Education_list(
      department: 'Department of Geo-resources and Geotechnical Engineering',
      imagePath: 'assets/mf84e-removebg-preview.png',
      uri: 'https://ggeitc.wixsite.com/website-2'
  );
  static const eight = Education_list(
      department: ' Graduate School',
      imagePath: 'assets/mf84e-removebg-preview.png',
      uri: 'https://grads.itc.edu.kh/'
  );
  static final List<Education_list> list = [
    first,
    second,
    third,
    four,
    five,
    six,
    seven,
    eight,
  ];
}


ExpansionTile Education_expansionTile(BuildContext context){
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
      title: Text(
        'Education',
        style: Theme.of(context).primaryTextTheme.titleMedium,
      ),
    children: <Widget>[
      ...Education_item.list.asMap().entries.map((e) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ListTile(
          title: Row(
            children: <Widget>[
              Container(
                height: 20,
                width: 20,
                child: ClipRRect(
                  child: Image.asset(e.value.imagePath),
                ),
              ),
              SizedBox(width: 5,),
              Expanded(
                child: Text(
                  overflow: TextOverflow.clip,
                  e.value.department,
                  style: Theme.of(context).primaryTextTheme.titleSmall,
                ),
              ),
            ],
          ),
          onTap: (){
            launchUrl(Uri.parse(e.value.uri));
          },
        ),
      )),
    ],
  );
}

// PopupMenuButton build_popup(BuildContext context){
//   return PopupMenuButton<Popup_list>(
//     onSelected: (Popup_list value) {
//       print('Selected: ${value.course}');
//     },
//     itemBuilder: (BuildContext context) {
//       return Popup_item.list_drawer.map((Popup_list item) {
//         return PopupMenuItem<Popup_list>(
//           value: item,
//           child: Text(item.course),
//         );
//       }).toList();
//     },
//   );
// }
