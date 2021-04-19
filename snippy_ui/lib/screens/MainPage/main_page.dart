import 'package:flutter/material.dart';
import 'package:snippy_ui/screens/Drawer/drawer.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String url = "";
    String customName = "";
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: DrawerComponent(),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/background2.png"),
            fit: BoxFit.cover,
          )),
          height: height,
          width: width,
          child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 50.0,
                        width: 350.0,
                        child: TextFormField(
                          validator: (val) =>
                              val.isEmpty ? 'Please enter a URL' : null,
                          obscureText: false,
                          decoration: InputDecoration(
                              hintText: 'Enter your URL',
                              labelText: 'URL',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )),
                          onChanged: (val) {
                            setState(() => url = val);
                          },
                        )),
                    SizedBox(height: 20.0),
                    SizedBox(
                        height: 50.0,
                        width: 350.0,
                        child: TextFormField(
                          obscureText: false,
                          decoration: InputDecoration(
                              hintText: 'Enter a custom name',
                              labelText: 'Custom Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )),
                          onChanged: (val) {
                            setState(() => customName = val);
                          },
                        )),
                  ]))),
    );
  }
}
