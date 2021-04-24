import 'package:flutter/material.dart';
import 'package:snippy_ui/screens/Welcome/welcome_screen.dart';
import 'package:snippy_ui/screens/Login/login_screen.dart';
import 'package:snippy_ui/screens/Register/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:snippy_ui/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:snippy_ui/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(home: Wrapper()),
    );
  }
}
