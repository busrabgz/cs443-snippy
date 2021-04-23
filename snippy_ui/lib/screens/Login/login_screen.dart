import 'package:flutter/material.dart';
import 'package:snippy_ui/screens/MainPage/main_page.dart';
import 'package:snippy_ui/screens/Register/register_screen.dart';
import 'package:snippy_ui/screens/Welcome/welcome_screen.dart';
import 'package:snippy_ui/services/auth.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = "";
  String password = "";
  String error = "";
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(61, 82, 155, 1.0),
        elevation: 10.0,
        toolbarHeight: 100,
          title: Text('Sign In', style: TextStyle(fontFamily: 'CaviarDreams', fontWeight: FontWeight.w700)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.house),
            iconSize: 40,
            color: Colors.white,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));
            }
          )
        ]
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/loginbackground.png"),
            fit: BoxFit.cover,
          )
        ),
        height: height,
        width: width,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height:1.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
              ),
              SizedBox(height:40.0),
              SizedBox(
                height: 50.0,
                width: 350.0,
                child: TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  obscureText: false,
                  decoration: InputDecoration(
                      hintText: 'Your Email',
                      hintStyle: TextStyle(fontFamily: 'CaviarDreams'),
                      labelText: 'Email',
                      labelStyle: TextStyle(fontFamily: 'CaviarDreams'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )
                  ),
                  onChanged: (val) {
                    setState(()=>email = val);
                  },
                )
              ),
              SizedBox(height:20.0),
              SizedBox(
                height: 50.0,
                width: 350.0,
                child: TextFormField(
                  validator: (val) => val.length < 6 ? 'Enter a valid password' : null,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Your Password',
                      hintStyle: TextStyle(fontFamily: 'CaviarDreams'),
                      labelText: 'Password',
                      labelStyle: TextStyle(fontFamily: 'CaviarDreams'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )
                  ),
                  onChanged: (val) {
                     setState(()=>password = val);
                  },
                )
              ),
              SizedBox(height: 30.0),
              SizedBox(
                height: 40.0,
                width: 300.0,
                child: TextButton(
                  child: Text(
                    "Sign In".toUpperCase(),
                      style: TextStyle(fontFamily: 'CaviarDreams', fontWeight: FontWeight.w700, fontSize: 14)
                  ),
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(5), //Defines Elevation
                      shadowColor: MaterialStateProperty.all(Colors.black), //Defines shadowColor
                     backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(61, 82, 155, 1.0)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      )
                    )
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if (result == null) {
                        setState(()=>error = "Sign in failed");
                      }
                      else {
                        print("sign in complete");
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                      }
                    }
                  }
                )
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));},
                      child: Text.rich(
                        TextSpan(
                          text: 'Forgot Password?',
                          style: TextStyle( fontFamily: 'CaviarDreams',
                            color: Colors.purple[300]
                          )
                        )
                      )
                    ),
                    GestureDetector(
                      onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));},
                      child: Text.rich(
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle( fontFamily: 'CaviarDreams',
                            color: Colors.purple[300]
                          )
                        )
                      )
                    ),
                  ],
                ),
              ),
              SizedBox(height:20.0),
            ],
          )
        )
      )
    );
  }
}