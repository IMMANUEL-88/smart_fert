import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_fert/screens/home.dart';
import 'package:smart_fert/utils/theme/theme.dart';

void main() {
  // Set the navigation bar color
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.green, // Custom color for navigation bar
      systemNavigationBarIconBrightness: Brightness.light, // Adjust icons for better visibility
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: EAppTheme.lightTheme,
      darkTheme: EAppTheme.darkTheme,
      themeMode: ThemeMode.system, // Automatically switches between light and dark modes
      home: const MyHomePage(),
    );
  }
}


