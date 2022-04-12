import 'package:flutter/material.dart';
import 'package:uisamples/Screens/Animations.dart';
import 'package:uisamples/Screens/Buttons.dart';
import 'package:uisamples/Screens/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const HomeScreen(),
      routes: {
        '/': (_) => const HomeScreen(),
        Buttons.routeName: (_) => const Buttons(),
        Animations.routeName: (_) => const Animations(),
      },
    );
  }
}
