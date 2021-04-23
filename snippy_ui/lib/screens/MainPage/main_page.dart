import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snippy_analytics_api/api.dart';
import 'package:snippy_core_api/api.dart';
import 'package:snippy_ui/screens/Welcome/welcome_screen.dart';
import 'package:snippy_ui/screens/analytics.dart';
import 'package:snippy_ui/services/auth.dart';

var buttonStyle = ButtonStyle(
    elevation: MaterialStateProperty.all(5), //Defines Elevation
    shadowColor: MaterialStateProperty.all(Colors.black), //Defines shadowColor
    backgroundColor:
        MaterialStateProperty.all<Color>(Color.fromRGBO(61, 82, 155, 1.0)),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))));

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final urlControllerApi = UrlControllerApi();
  final String email = FirebaseAuth.instance.currentUser.email;
  Future<List<Url>> temp;
  //final List<String> temp = ["url1asdasd", "url2", "url3", "url4","url2","url2","url2","url2","url2"];
  String url = "";
  String customName = "";

  void copyToClipboard(String text) {
    Clipboard.setData(new ClipboardData(text: text)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("URL: " + text + " is copied to clipboard"),
        behavior: SnackBarBehavior.floating,
      ));
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    temp = FirebaseAuth.instance.currentUser.getIdToken().then((token) =>
        urlControllerApi.getUrlForUser(token, page: 0, size: 50, sort: []));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(61, 82, 155, 1.0),
        elevation: 10.0,
        toolbarHeight: 40,
        leading: const Icon(Icons.person),
        title: Text(email,
            style: TextStyle(
                fontFamily: 'CaviarDreams',
                fontWeight: FontWeight.w700,
                fontSize: 15.0)),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.logout),
              iconSize: 30,
              color: Colors.white,
              onPressed: () async {
                _auth.signOut();
                Navigator.popUntil(context, (route) => route.isFirst);
              })
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
        )),
        height: height,
        width: width,
        child: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            SizedBox(height: 130.0),
            SizedBox(
                height: 50.0,
                width: 280.0,
                child: TextFormField(
                  obscureText: false,
                  maxLines: 1,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Custom name',
                    hintStyle: TextStyle(fontFamily: 'CaviarDreams'),
                    labelText: 'Generate custom URL',
                    labelStyle: TextStyle(fontFamily: 'CaviarDreams'),
                  ),
                  onChanged: (val) {
                    setState(() => customName = val);
                  },
                )),
            SizedBox(height: 10.0),
            SizedBox(
                height: 50.0,
                width: 350.0,
                child: TextFormField(
                  validator: (val) => val.isEmpty ? 'Please enter a URL' : null,
                  obscureText: false,
                  maxLines: 1,
                  decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Enter your URL',
                      hintStyle: TextStyle(fontFamily: 'CaviarDreams'),
                      labelText: 'URL',
                      labelStyle: TextStyle(fontFamily: 'CaviarDreams'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                  onChanged: (val) {
                    setState(() => url = val);
                  },
                )),
            SizedBox(height: 20.0),
            SizedBox(
                height: 40.0,
                width: 300.0,
                child: TextButton(
                    child: Text("Snip!".toUpperCase(),
                        style: TextStyle(
                            fontFamily: 'CaviarDreams',
                            fontWeight: FontWeight.w700,
                            fontSize: 18)),
                    style: buttonStyle,
                    onPressed: () {
                      try {
                        FocusScope.of(context).unfocus();
                        print(url);
                        FirebaseAuth.instance.currentUser
                            .getIdToken()
                            .then((token) {
                          if (customName == "") {
                            urlControllerApi
                                .create(url, faAuth: token)
                                .then((result) {
                              urlControllerApi
                                  .getUrlForUser(token)
                                  .then((urls) => setState(() {
                                        temp = Future.value(urls);
                                      }));
                            });
                          } else {
                            urlControllerApi
                                .createNamed(
                                    token,
                                    Url(
                                        id: customName,
                                        url: url,
                                        ownerEmail: email))
                                .then((result) {
                              urlControllerApi
                                  .getUrlForUser(token)
                                  .then((urls) => setState(() {
                                        temp = Future.value(urls);
                                      }));
                            });
                          }
                        });
                      } catch (e) {
                        print(
                            'Exception when calling UrlControllerApi->create: $e\n');
                      }
                    })),
            SizedBox(height: 30.0),
            Expanded(
              child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Divider(color: Colors.blueAccent),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Previous URLs',
                              style: TextStyle(
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 5.0,
                                      color: Color.fromRGBO(61, 82, 155, 1.0),
                                    )
                                  ],
                                  color: Color.fromRGBO(61, 82, 155, 1.0),
                                  fontFamily: 'CaviarDreams',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.blueAccent),
                      Expanded(
                        child: FutureBuilder<List<Url>>(
                            future: temp,
                            builder: (context, snapshot) {
                              print(snapshot.connectionState);
                              return snapshot.hasData
                                  ? ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: snapshot.data.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          height: 60,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            elevation: 5.0,
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1.0),
                                            child: ListTile(
                                              onTap: () {
                                                FocusScope.of(context)
                                                    .unfocus();

                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AnalyticsScreen(
                                                              id: snapshot
                                                                  .data[index]
                                                                  .id,
                                                            )));
                                              },
                                              title: Text(
                                                  snapshot.data[index].url,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          61, 82, 155, 1.0))),
                                              trailing: IconButton(
                                                icon: const Icon(
                                                  Icons.copy,
                                                ),
                                                color: Color.fromRGBO(
                                                    61, 82, 155, 1.0),
                                                onPressed: () {
                                                  copyToClipboard(
                                                      "http://snippy.me/u/" +
                                                          snapshot
                                                              .data[index].id);
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      })
                                  : Text("Loading");
                            }),
                      ),
                    ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
