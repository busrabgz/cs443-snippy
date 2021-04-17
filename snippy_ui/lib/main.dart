import 'package:flutter/material.dart';
import 'package:snippy_ui/screens/Welcome/welcome_screen.dart';
import 'package:snippy_ui/screens/Login/login_screen.dart';
import 'package:snippy_ui/screens/Register/register_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Snippy',
      theme: ThemeData(
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: RegisterScreen(),
    );
  }
}