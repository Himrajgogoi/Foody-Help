import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foody_help/models/hostels.dart';
import 'package:foody_help/screens/home/buildTile.dart';
import 'package:foody_help/screens/loading.dart';
import 'package:provider/provider.dart';


class FoodAvailable extends StatefulWidget {
  @override
  _FoodAvailableState createState() => _FoodAvailableState();
}

class _FoodAvailableState extends State<FoodAvailable> {

  @override
  Widget build(BuildContext context) {
    int count=0;
    List<Hostel> hostels = Provider.of<List<Hostel>>(context);
    if(hostels == null){
      hostels = [];
    }

    return Scaffold(
       body: Padding(
         padding: EdgeInsets.only(top: 16.0,bottom: 10.0),
         child: ListView.builder(itemCount: hostels.length,
         itemBuilder: (context, index){
           return BuildTile(hostel: hostels[index]);
         },),
       )
    );
  }
}
