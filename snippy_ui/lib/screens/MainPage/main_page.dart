import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snippy_core_api/api.dart';
import 'package:snippy_ui/screens/Drawer/drawer.dart';
import 'package:snippy_ui/services/auth.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final urlControllerApi = UrlControllerApi();
  List<String> temp = [];
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
  
  @override
  Widget build(BuildContext context) {
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
                      width: 280.0,
                      child: TextFormField(
                        obscureText: false,
                        decoration: InputDecoration(
                            hintText: 'Enter a custom name!',
                            labelText: 'Custom name',
                          ),
                        onChanged: (val) {
                          setState(() => customName = val);
                        },
                      )
                    ),
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
                            labelText: 'URL',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )),
                        onChanged: (val) {
                          setState(() => url = val);
                        },
                      )
                  ),
                    SizedBox(height: 20.0),
                    SizedBox(
                      height: 40.0,
                      width: 300.0, 
                      child: TextButton(
                        child: Text("Snippy Me!".toUpperCase(), style: TextStyle(fontSize: 14)),
                        onPressed: () {
                          try {
                            FocusScope.of(context).unfocus();
                            print(url);
                            FirebaseAuth.instance.currentUser.getIdToken().then((token) => urlControllerApi.create(url, faAuth:token).then((result) {
                              print(token);
                              urlControllerApi.getUrlForUser(token).then((array) => temp.addAll(array));
                              print(temp);
                              copyToClipboard("http://snippy.me/u/" + result);
                            }));
                          } catch (e) {
                            print('Exception when calling UrlControllerApi->create: $e\n');
                          }
                        }
                      )
                    ),

                    SizedBox(height: 50.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Previous Links',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w400),),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1)
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 280,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: temp.length,
                              itemBuilder: (context,index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  elevation: 5.0,
                                  color: Colors.purple[100], 
                                  child: ListTile(
                                    onTap: () {

                                    },
                                    title: Text(
                                      temp[index]
                                    ),

                                  )
                                );
                              }
                            ),
                          )
                          
                        ]
                    )
                  )
                ])
                ),
        )
    );
  }
}
