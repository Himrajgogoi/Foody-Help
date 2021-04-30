import 'package:flutter/material.dart';
import 'package:foody_help/screens/authenticate/login.dart';
import 'package:foody_help/screens/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool signIn = true;
  void toggleSignedIn(){
    setState(() {
      signIn = !signIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(signIn){
      return SignIn(toggle: toggleSignedIn);
    }
    else{
      return Register(toggle: toggleSignedIn);
    }
  }
}
