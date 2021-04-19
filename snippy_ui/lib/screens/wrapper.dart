import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snippy_ui/screens/MainPage/main_page.dart';
import 'package:snippy_ui/screens/Register/register_screen.dart';
import 'package:snippy_ui/screens/Welcome/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return RegisterScreen();
    }
    else {
      return MainScreen();
    }
  }
}