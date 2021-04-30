import 'package:firebase_core/firebase_core.dart';
import  'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foody_help/models/user.dart';
import 'package:foody_help/services/database.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;


  User_ _userFromFireBaseUser(User user){
    return user != null?  User_(uid: user.uid):null;
  }

  Stream<User_>  get user{
    return _auth.authStateChanges().map(_userFromFireBaseUser);
}
  ///Sign in Anonymously
  Future signInAnon() async {
    try{
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFireBaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  ///Sign Out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }


  ///Register
  Future registerWithEmailAndPassword(String email,
      String password,
      String Hostel_number,
      String Hostel_name,
      String Contact_number,
      String Dp,
      String Food_left) async {
   try{
     UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
     User user = result.user;

     await DatabaseService(uid: user.uid).updateHostelData(Hostel_number, Hostel_name, Contact_number, Dp, Food_left);
     return _userFromFireBaseUser(user);
   }
   catch(e){
     print(e.toString());
     return null;
   }
  }

  Future signInWithEmailAndPassword(String email, password) async {
    String exists;
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      await DatabaseService(uid: user.uid).hostelCollection.doc(user.uid).get().then((value){
        if(value.exists){
          exists = "yes";
        }
        else{
          exists = "no";
        }
      });
      if(exists == "yes") return _userFromFireBaseUser(user);
      else{
        await DatabaseService(uid: user.uid).updateHostelData('N/A', 'N/A', 'N/A', 'N/A', 'N/A');
        return _userFromFireBaseUser(user);
      }
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}