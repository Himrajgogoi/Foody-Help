import "package:flutter/material.dart";
import 'package:foody_help/models/user.dart';
import 'package:provider/provider.dart';
import 'package:foody_help/screens/authenticate/authenticate.dart';
import 'package:foody_help/screens/home/home.dart';
import 'home/home.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User_>(context);
    if(user == null){
      return Authenticate();
    }
    else{
      return Home();
    }
  }
}

