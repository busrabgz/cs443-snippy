import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snippy_ui/screens/Login/login_screen.dart';
import 'package:snippy_ui/screens/Register/register_screen.dart';
import 'package:snippy_core_api/api.dart';
import 'package:snippy_ui/services/auth.dart';
import 'package:flutter/services.dart';
import 'package:snippy_ui/globals.dart' as globals;

var buttonStyle = ButtonStyle(
    elevation: MaterialStateProperty.all(5), //Defines Elevation
    shadowColor: MaterialStateProperty.all(Colors.black), //Defines shadowColor
    backgroundColor:
        MaterialStateProperty.all<Color>(Color.fromRGBO(61, 82, 155, 1.0)),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))));

class ErrorDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    return AlertDialog(
      title: Text("Invalid URL"),
      content: Text("This URL is invalid."),
      actions: [
        okButton,
      ],
    );
  }
}

class URLDialog extends StatelessWidget {
  final String resultUrl;
  final Function onCopy;

  URLDialog({Key key, this.resultUrl, this.onCopy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      elevation: 15,
      backgroundColor: Color.fromRGBO(62, 84, 156, 1.0),
      child: Container(
        height: 300.0,
        width: 360.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 100.0),
            Text(resultUrl,
                style: TextStyle(fontSize: 21.0, color: Colors.white)),
            SizedBox(height: 100.0),
            Align(
              alignment: FractionalOffset.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10.0, right: 10.0),
                child: IconButton(
                  icon: const Icon(Icons.copy_outlined),
                  color: Colors.white,
                  splashRadius: 25,
                  iconSize: 25,
                  alignment: Alignment.bottomCenter,
                  onPressed: onCopy,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String url = "";
  String resultUrl = "";
  String error = "";

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
            alignment: Alignment.center,
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
              error != null
                  ? Text(
                      error,
                      style: TextStyle(color: Colors.redAccent),
                    )
                  : Text(''),
              SizedBox(height: 40.0),
              SizedBox(
                height: 50.0,
                width: 350.0,
                child: TextField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Enter your URL here.',
                    hintStyle: TextStyle(fontFamily: 'CaviarDreams'),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(109, 143, 192, 1.0),
                          width: 2.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(109, 143, 192, 1.0),
                          width: 5.0),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      error = "";
                      url = val;
                    });
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
                    child: globals.countLeft
                        ? Text("Snip!".toUpperCase(),
                            style: TextStyle(
                                fontFamily: 'CaviarDreams',
                                fontWeight: FontWeight.w700,
                                fontSize: 18))
                        : Text("Out of quota!",
                            style: TextStyle(
                                fontFamily: 'CaviarDreams',
                                fontWeight: FontWeight.w700,
                                fontSize: 18)),
                    onPressed: globals.clickCounter >= 3
                        ? () {
                            globals.countLeft = false;
                          }
                        : () {
                            FocusScope.of(context).unfocus();

                            final currentUser =
                                FirebaseAuth.instance.currentUser;

                            final resultFuture = (currentUser != null)
                                ? currentUser.getIdToken().then((token) =>
                                    urlControllerApi.create(url, faAuth: token))
                                : urlControllerApi.create(url);

                            resultFuture.then((result) {
                              globals.clickCounter += 1;
                              setState(() =>
                                  resultUrl = "http://snippy.me/u/" + result);

                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return URLDialog(
                                      resultUrl: resultUrl,
                                      onCopy: () => copyToClipboard(resultUrl),
                                    );
                                  });
                            }).catchError((e, stackTrace) {
                              // show the dialog
                              setState(() => error =
                                  "Invalid URL, please provide a valid HTTP or HTTPS link.");
                              print(
                                  'Exception when calling UrlControllerApi->create: $e\n');
                            });
                          },
                    style: ButtonStyle(
                        elevation:
                            MaterialStateProperty.all(5), //Defines Elevation
                        shadowColor: MaterialStateProperty.all(
                            Colors.black), //Defines shadowColor
                        backgroundColor: globals.countLeft
                            ? MaterialStateProperty.all<Color>(
                                Color.fromRGBO(61, 82, 155, 1.0))
                            : MaterialStateProperty.all<Color>(Colors.red),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(18.0))))),
                //side: BorderSide(color: Colors.white))))),
              ),
              SizedBox(
                height: 150.0,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 40.0,
                      width: 150.0,
                      child: TextButton(
                        child: Text("Sign in".toUpperCase(),
                            style: TextStyle(
                                fontFamily: 'CaviarDreams',
                                fontWeight: FontWeight.w700,
                                fontSize: 16)),
                        style: buttonStyle,
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
                              style: TextStyle(
                                  fontFamily: 'CaviarDreams',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16)),
                          style: buttonStyle,
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
