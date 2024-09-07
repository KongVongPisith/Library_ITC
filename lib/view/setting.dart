import 'package:flutter/material.dart';
import 'package:itc_library/widget/Toggle_switch.dart';
import 'package:itc_library/widget/back_appBar.dart';
import 'package:itc_library/widget/theme.dart';
import 'package:itc_library/widget/theme_provider.dart';
import 'package:provider/provider.dart';
class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  @override
  Widget build(BuildContext context) {

    final String background;
    final theme = Theme.of(context);
    if(theme.brightness == Brightness.light){
      background = Custom_theme.lightBackgroundImage;
    }else{
      background = Custom_theme.darkBackgroundImage;
    }
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(background),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: Back_appBar(context, "Setting"),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                ListTile(
                  onTap: (){

                  },
                  title: Row(
                    children: <Widget>[
                      Text(
                        'Theme Mode',
                        style: Theme.of(context).primaryTextTheme.titleMedium,
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: (){
                            themeProvider.setTheme(themeProvider.getTheme() == Custom_theme.darkTheme? Custom_theme.lightTheme:Custom_theme.darkTheme);
                          },
                          // icon: Icon(
                          //     themeProvider.getTheme() == Custom_theme.darkTheme?Icons.light_mode_outlined:Icons.dark_mode_outlined),
                        icon: ThemeToggleSwitch(),
                      ),
                    ],
                  ),
                  dense: true,
                  tileColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ],

            )
          )
        ),
      ),
    );
  }
}
