import 'package:flutter/material.dart';
import 'package:snippy_ui/screens/Login/login_screen.dart';
import 'package:snippy_ui/services/auth.dart';
import 'package:snippy_ui/screens/Welcome/welcome_screen.dart';


class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
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
          key:_formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Sign Up',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
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
                    hintText: 'Your Username',
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )
                  )
                )
              ),
              SizedBox(height:20.0),
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
                    "Sign Up!".toUpperCase(),
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
                      dynamic result = await _auth.createNewUser(email, password);
                      if (result == null) {
                        setState(()=>error = "Register failed");
                      }
                      else {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      }
                    }
                  }
                )
              ),
              SizedBox(height:20.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                },
                child: Text.rich(
                  TextSpan(
                    text: "Already have an account?  ",
                    children: [
                      TextSpan(
                        text: 'Sign In',
                        style: TextStyle(
                          color: Colors.purple[300]
                        )
                      )
                    ]
                  )
                )
              )
            ],
            
          )
        )
      )
    );
  }
}