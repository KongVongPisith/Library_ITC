import 'package:flutter/material.dart';
import 'package:itc_library/view/home.dart';
import 'package:itc_library/view/home.dart';
import 'package:itc_library/widget/theme.dart';
import 'package:itc_library/widget/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      ChangeNotifierProvider(
          create: (_)=>ThemeProvider(Custom_theme.lightTheme),
          child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      theme: themeProvider.getTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home':(context)=>Home_page(),
      },
    );
  }
}

