import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:itc_library/view/event.dart';
import 'package:itc_library/view/home.dart';
import 'package:itc_library/widget/drawer_component/darkMode_tile.dart';
import 'package:itc_library/widget/drawer_component/contact_expansiontile.dart';
import 'package:itc_library/widget/drawer_component/education_expansionTile.dart';
import 'package:itc_library/widget/drawer_component/resoure_expansiontile.dart';
import 'package:itc_library/widget/drawer_component/service_expansiontile.dart';
import 'package:itc_library/widget/theme.dart';

class Drawer_list {
  final String title;

  const Drawer_list({
    required this.title,
  });
}

class Drawer_item {
  static const Home = Drawer_list(title: 'Home');
  static const Event = Drawer_list(title: 'Events');

  static final List<Drawer_list> list_drawer = [
    Home,
    Event,
  ];
}

Theme Drawer_theme(BuildContext context) {
  final theme = Theme.of(context);
  return Theme(
    data: theme.copyWith(
      canvasColor: Colors.transparent,
    ),
    child: Custom_drawer(),
  );
}
class Custom_drawer extends StatefulWidget {
  const Custom_drawer({super.key});

  @override
  State<Custom_drawer> createState() => _Custom_drawerState();
}

class _Custom_drawerState extends State<Custom_drawer> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final String background;
    if (theme.backgroundColor == Colors.white) {
      background = Custom_theme.drawerLightBackground;
    } else {
      background = Custom_theme.drawerDarkBackground;
    }

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(background),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Material(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/square_logo.png'),
                      fit: BoxFit.contain,
                    ),
                    border: Border.all(color: Colors.white),
                  ),
                ),
              ),
              Container(
                height: 1,
                color: Colors.transparent,
              ),
              // DarkMode_tile(context),
              ...Drawer_item.list_drawer.asMap().entries.map(
                    (entry) => Column(
                  children: <Widget>[
                    Container(
                      child: ListTile(
                        selectedTileColor: Colors.blue,
                        // splashColor: Colors.blue,
                        selectedColor: Colors.blue,
                        title: Container(
                          height: 50,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            entry.value.title,
                            style: Theme.of(context).primaryTextTheme.titleMedium,
                          ),
                        ),
                        onTap: () {

                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                            if (entry.value == Drawer_item.Home) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Home_page()));
                            } else if (entry.value == Drawer_item.Event) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Event_page()));
                            }
                          },
                      ),
                    ),
                    // if(entry.key<Drawer_item.list_drawer.length-1)
                    //   const Divider(color: Colors.black12,thickness: 0,),
                    Container(
                      height: 1,
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),
              Resource_ExpansionTile(context),
              Container(
                height: 1,
                color: Colors.transparent,
              ),
              Service_ExpansionTile(context),
              Container(
                height: 1,
                color: Colors.transparent,
              ),
              Contact_expansionTile(context),
              Container(
                height: 1,
                color: Colors.transparent,
              ),
              Education_expansionTile(context),
            ],
          ),
        ),
      )
    );
  }
}


// Drawer Custom_Drawer(BuildContext context) {
//   final theme = Theme.of(context);
//   final String background;
//   if (theme.backgroundColor == Colors.white) {
//     background = Custom_theme.drawerLightBackground;
//   } else {
//     background = Custom_theme.drawerDarkBackground;
//   }
//   bool _isSelect = false;
//   return Drawer(
//       child: Container(
//     decoration: BoxDecoration(
//       image: DecorationImage(
//         image: AssetImage(background),
//         fit: BoxFit.fitHeight,
//       ),
//     ),
//     child: Material(
//       child: ListView(
//         children: <Widget>[
//           ListTile(
//             title: Container(
//               height: 200,
//               width: 200,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 image: DecorationImage(
//                   image: AssetImage('assets/square_logo.png'),
//                     fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             height: 1,
//             color: Colors.transparent,
//           ),
//           DarkMode_tile(context),
//           ...Drawer_item.list_drawer.asMap().entries.map(
//                 (entry) => Column(
//                   children: <Widget>[
//                     Container(
//                       child: ListTile(
//                         selectedTileColor: Colors.red,
//                         splashColor: Colors.blue,
//                         selectedColor: Colors.amber,
//                         selected: _isSelect,
//                         title: Container(
//                           height: 50,
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             entry.value.title,
//                             style: Theme.of(context).textTheme.bodyLarge,
//                           ),
//                         ),
//                         onTap: () {
//                           Navigator.of(context)
//                               .popUntil((route) => route.isFirst);
//                           if (entry.value == Drawer_item.Home) {
//                             Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (BuildContext context) =>
//                                         Home_page()));
//                           } else if (entry.value == Drawer_item.Event) {
//                             Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (BuildContext context) =>
//                                         Event_page()));
//                           }
//                         },
//                       ),
//                     ),
//                     // if(entry.key<Drawer_item.list_drawer.length-1)
//                     //   const Divider(color: Colors.black12,thickness: 0,),
//                     Container(
//                       height: 1,
//                       color: Colors.transparent,
//                     ),
//                   ],
//                 ),
//               ),
//           Resource_ExpansionTile(context),
//           Container(
//             height: 1,
//             color: Colors.transparent,
//           ),
//           Service_ExpansionTile(context),
//           Container(
//             height: 1,
//             color: Colors.transparent,
//           ),
//           Contact_expansionTile(context),
//           Container(
//             height: 1,
//             color: Colors.transparent,
//           ),
//           Education_expansionTile(context),
//         ],
//       ),
//     ),
//   ));
// }

// Drawer Custom_Drawer(BuildContext context) {
//   return Drawer(
//     child: Consumer<ThemeProvider>(
//       builder: (context, themeProvider, _) {
//         final String background = themeProvider.getTheme().backgroundColor == Colors.white
//             ? Custom_theme.drawerLightBackground
//             : Custom_theme.drawerDarkBackground;
//
//         return Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(background),
//               fit: BoxFit.fitHeight,
//             ),
//           ),
//           child: Material(
//             child: ListView(
//               children: <Widget>[
//                 ListTile(
//                   title: Container(
//                     height: 200,
//                     child: Center(
//                       child: ClipRRect(
//                         child: Image.asset('assets/library.png'),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: 1,
//                   color: Colors.white,
//                 ),
//                 // Other list tiles...
//               ],
//             ),
//           ),
//         );
//       },
//     ),
//   );
// }
