import 'package:flutter/material.dart';
import 'package:foody_help/services/auth.dart';
import 'package:foody_help/shared/textdecoration.dart';

import '../loading.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn({this.toggle});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  String username;
  String password;
  String message = ' ';

  final _formkey = GlobalKey<FormState>();
  final AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[900],
        body:Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Center(
                child: Form(
                  key: _formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text('Helping those in need',
                          style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),),
                        SizedBox(height: 12.0,),
                        TextFormField(
                          decoration: textDecoration.copyWith(hintText: 'username'),
                          onChanged: (val){
                            setState(() {
                              username = val.toLowerCase()+'@foodyhelpmail.com';
                            });
                          },
                          validator: (val)=> val.isEmpty? 'Enter a valid name': null,

                        ),
                        SizedBox(height: 12.0,),
                        TextFormField(
                          decoration: textDecoration.copyWith(hintText: 'password'),
                          obscureText: true,
                          onChanged: (val){
                            setState(() {
                              password = val;
                            });
                          },
                          validator: (val) => val.length <6? "Password must be at least 6 characters long": null,
                        ),
                        SizedBox(height: 12.0,),
                        TextButton( onPressed: () async{
                          if(_formkey.currentState.validate()){
                            dynamic result = await auth.signInWithEmailAndPassword(username, password);
                            if(result == null){
                              setState(() {
                                message = "Error";
                              });
                            }
                          }
                        },
                            child: Padding(
                              padding: const EdgeInsets.all(.0),
                              child: Text('Sign in',
                                style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.yellowAccent,
                                ),),
                            )),
                        SizedBox(height: 12.0,),
                        Row(
                          children: [
                            Text('Dont have an account?'),
                            SizedBox(width:5.0),
                            InkWell(
                              child: Text('Register',
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                              onTap: (){
                                widget.toggle();
                              },
                            )
                          ],
                        ),
                        SizedBox(height: 12.0,),
                        Text('$message', style: TextStyle(color: Colors.red))

                      ],
                    ),
                  ),
                ),
              )
          ),
        )
    );
  }
}
