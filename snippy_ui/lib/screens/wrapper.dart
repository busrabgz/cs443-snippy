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
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data != null) {
          return RegisterScreen();
        }
        else {
          return MainScreen();
        }
      } ,
    );


  }
}
