import 'package:flutter/material.dart';
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
        backgroundColor: Colors.purple[100],
        elevation: 0.0,
        title: Text('Sign In'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.house),
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
            image: AssetImage("assets/images/background2.png"),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Sign In',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
                  ],
                ),
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
                    labelText: 'Email',
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
                    labelText: 'Password',
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
                    "Sign In!".toUpperCase(),
                    style: TextStyle(fontSize: 14)
                  ),
                  style: ButtonStyle(
                     backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(156, 239, 182, 1)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.white)
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
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
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
                          style: TextStyle(
                            color: Colors.purple[300]
                          )
                        )
                      )
                    ),
                    GestureDetector(
                      onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));},
                      child: Text.rich(
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            color: Colors.purple[900]
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