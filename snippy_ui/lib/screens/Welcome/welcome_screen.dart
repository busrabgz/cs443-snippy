import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snippy_ui/screens/Drawer/drawer.dart';
import 'package:snippy_ui/screens/Login/login_screen.dart';
import 'package:snippy_ui/screens/Register/register_screen.dart';
import 'package:snippy_core_api/api.dart';
import 'package:snippy_ui/services/auth.dart';
import 'package:flutter/services.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String url = "";

  void copyToClipboard(String text) {
    Clipboard.setData(new ClipboardData(text: text)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("URL: " + text + " is copied to clipboard"),
        behavior: SnackBarBehavior.floating,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final urlControllerApi = UrlControllerApi();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          /*
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(20, 33, 45, 1),
              Color.fromRGBO(17, 85, 113, 1),
              Color.fromRGBO(49, 175, 180, 1)
            ],
            tileMode: TileMode.repeated
          )*/
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width,
                height: height * 0.4,
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Text('Login',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              SizedBox(height: 40.0),
              SizedBox(
                height: 50.0,
                width: 350.0,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your URL here.',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(color: Color.fromRGBO(109, 143, 192, 1.0), width: 2.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(color: Color.fromRGBO(109, 143, 192, 1.0), width: 5.0),
                    ),
                  ),
                  onChanged: (val) {
                    print(val);
                    setState(() => url = val);
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 45.0,
                width: 200.0,
                child: TextButton(
                    child: Text("Snip!".toUpperCase(),
                        style: TextStyle(fontFamily: 'Quicksand', fontSize: 18)),
                    onPressed: () {
                      try {
                        print(url);
                        FocusScope.of(context).unfocus();
                        final result = urlControllerApi.create(url);

                        FirebaseAuth.instance.currentUser
                            .getIdToken()
                            .then((token) {
                          print(token);
                          urlControllerApi
                              .getUrlForUser(token)
                              .then((value) => print(value));
                        });

                        FirebaseAuth.instance.currentUser.getIdToken().then(
                            (token) => urlControllerApi
                                .create1(
                                    token,
                                    Url(
                                        id: "gog",
                                        url: "http://www.google.com"))
                                .then((value) => print(value)));

                        result.then((value) =>
                            copyToClipboard("http://snippy.me/u/" + value));
                      } catch (e) {
                        print(
                            'Exception when calling UrlControllerApi->create: $e\n');
                      }
                    },
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(5), //Defines Elevation
                        shadowColor: MaterialStateProperty.all(Colors.black), //Defines shadowColor
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(61, 82, 155, 1.0)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0))))),
                                    //side: BorderSide(color: Colors.white))))),
              ),
              SizedBox(
                height: 150.0,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 40.0,
                      width: 150.0,
                      child: TextButton(
                        child: Text("Sign in".toUpperCase(),
                            style: TextStyle(fontSize: 16)),
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(5), //Defines Elevation
                            shadowColor: MaterialStateProperty.all(Colors.black), //Defines shadowColor
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(61, 82, 155, 1.0)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0)))),
                                    //side: BorderSide(color: Colors.white)))),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                      width: 150.0,
                      child: TextButton(
                          child: Text("Sign up".toUpperCase(),
                              style: TextStyle(fontSize: 16)),
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(5), //Defines Elevation
                              shadowColor: MaterialStateProperty.all(Colors.black), //Defines shadowColor
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromRGBO(61, 82, 155, 1.0)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0)))),
                                      //side: BorderSide(color: Colors.white)))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen()));
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
