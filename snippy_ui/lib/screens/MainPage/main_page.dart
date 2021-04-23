import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snippy_core_api/api.dart';
import 'package:snippy_ui/screens/Drawer/drawer.dart';
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
  final FirebaseAuth fbauth = FirebaseAuth.instance;
  List<Url> temp = [];
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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            backgroundColor: Color.fromRGBO(61, 82, 155, 1.0),
            elevation: 10.0,
            toolbarHeight: 40,
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
            )
        ),
        drawer: DrawerComponent(),
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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 130.0),
                    SizedBox(
                        height: 50.0,
                        width: 280.0,
                        child: TextFormField(
                          obscureText: false,
                          decoration: InputDecoration(
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
                          validator: (val) =>
                              val.isEmpty ? 'Please enter a URL' : null,
                          obscureText: false,
                          decoration: InputDecoration(
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
                                style: TextStyle(fontFamily: 'CaviarDreams', fontWeight: FontWeight.w700, fontSize: 18)),
                            style: buttonStyle,
                            onPressed: () {
                              try {
                                FocusScope.of(context).unfocus();
                                print(url);
                                FirebaseAuth.instance.currentUser
                                    .getIdToken()
                                    .then((token) => urlControllerApi
                                            .create(url, faAuth: token)
                                            .then((result) {
                                          print(token);
                                          urlControllerApi
                                              .getUrlForUser(token)
                                              .then((res) =>
                                                  setState(() => temp = res));

                                          print(temp);
                                          copyToClipboard(
                                              "http://snippy.me/u/" + result);
                                        }));
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Previous URLs',
                                          style: TextStyle( color: Color.fromRGBO(61, 82, 155, 1.0), fontFamily: 'CaviarDreams',
                                              fontSize: 20.0, fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: FutureBuilder(
                                      future: FirebaseAuth.instance.currentUser.getIdToken().then((token)=>urlControllerApi.getUrlForUser(token)),
                                      builder: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: temp.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(30.0),
                                                ),
                                                elevation: 5.0,
                                                color: Colors.blue[100],
                                                child: ListTile(
                                                  onTap: () {},
                                                  title: Text(temp[index].url, style: TextStyle(color: Colors.white)),
                                                  trailing: IconButton(
                                                    icon: const Icon(
                                                      Icons.copy,
                                                    ),
                                                    onPressed: () {
                                                      copyToClipboard("https://snippy.me/u/" + temp[index].id);
                                                    },
                                                  ),
                                                ));
                                          }),
                                    ),
                                  )
                                ]))
                    ),
                  ])),
        ));
  }
}
