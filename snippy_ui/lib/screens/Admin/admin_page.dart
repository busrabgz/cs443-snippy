import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snippy_core_api/api.dart';
import 'package:snippy_ui/screens/analytics.dart';
import 'package:snippy_ui/services/auth.dart';


class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final AuthService _auth = AuthService();
  final authControllerApi = AuthControllerApi();
  final urlControllerApi = UrlControllerApi();
  Future<List<String>> temp;
  Future<List<Url>> userUrls;
  final String email = FirebaseAuth.instance.currentUser.email;

  @override
  void initState() {
    super.initState();
    print(email);
    temp = authControllerApi.getUsers(email);
  }

Widget setupAlertDialoadContainer() {
    return Container(
      width: double.maxFinite,
      child: FutureBuilder<List<Url>>(
        future: userUrls,
        builder: (context, snapshot) {
          print(snapshot.connectionState);
          return snapshot.hasData
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.length,
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
                        ),
                      ),
                    );
                  })
              : Text("Loading");
        }),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(61, 82, 155, 1.0),
        elevation: 10.0,
        toolbarHeight: 40,
        leading: const Icon(Icons.admin_panel_settings),
        title: Text("Admin Dashboard",
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
          image :DecorationImage(
            image: AssetImage("assets/images/bgwithoutlogo.png"),
            fit: BoxFit.cover,
          )
        ),
        child:Expanded(
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
                              'Users',
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
                        child: FutureBuilder<List<String>>(
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
                                                FocusScope.of(context).unfocus();
                                                FirebaseAuth.instance.currentUser.getIdToken().then((token)=>  urlControllerApi.getUrlForUserFromAdmin(token, snapshot.data[index]).then((res)=>userUrls = Future.value(res)));
                                                showDialog(
                                                  context: context, 
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text("try"),
                                                      content: setupAlertDialoadContainer()
                                                    );
                                                  }
                                                );

                                              },
                                              title: Text(
                                                  snapshot.data[index],
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          61, 82, 155, 1.0))),
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
      ),
    );
  }
}