import 'package:flutter/material.dart';
import 'package:snippy_ui/screens/Welcome/welcome_screen.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background2.png"),
            fit: BoxFit.cover,
          )
        ),
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height:50.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Sign In',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              SizedBox(height:40.0),
              SizedBox(
                height: 50.0,
                width: 350.0,
                child: TextField(
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
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Your Password',
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )
                  )
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