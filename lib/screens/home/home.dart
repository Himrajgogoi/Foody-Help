import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foody_help/models/hostels.dart';
import 'package:foody_help/screens/home/food_available.dart';
import 'package:foody_help/screens/home/settings.dart';
import 'package:foody_help/services/auth.dart';
import 'package:foody_help/services/database.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  String settings;
  @override
  Widget build(BuildContext context) {
    void showSettings(){
      showModalBottomSheet(context:context, builder: (context){
        return Container(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: HostelSettings(),
        );
      });
    }

    void showNGO() {
      showModalBottomSheet(context:context, builder: (context){
        return Container(
          color: Colors.grey[900],
          padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Information on NGO", style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15.0)),
              Divider(height: 20.0, thickness:2.0, endIndent: 5.0, indent: 5.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex:2,
                    child: Text("NGO", style: TextStyle(color: Colors.white))
                  ),
                  Expanded(
                    flex:4,
                    child: Text("<name of NGO>", style: TextStyle(color: Colors.white))
                  )
                ],
              ),
              Divider(
                height: 20.0, thickness:2.0, endIndent: 5.0, indent: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("<Contact number>", style: TextStyle(color: Colors.white)),
                  InkWell(
                    onTap: (){
                      launch("tel://<phone_number>");
                    },
                    child: Icon(Icons.phone, color: Colors.blueAccent,)
                  )
                ],
              ),
              Divider(
                height: 12.0, thickness:2.0, endIndent: 5.0, indent: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex:2,
                      child: Text("Address", style: TextStyle(color: Colors.white))
                  ),
                  Expanded(
                      flex:4,
                      child: Text("<address of NGO>", style: TextStyle(color: Colors.white))
                  )
                ],
              ),
            ],
          )
        );
      });
    }

    return StreamProvider<List<Hostel>>.value(
      value: DatabaseService().hostels,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Food Available"),
          backgroundColor: Colors.blue[900],
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 18, 8.0, 0),
              child: InkWell(
                onTap: (){
                  showNGO();
                },
                child: Text("NGO", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0
                )),
              ),
            ),
            FlatButton.icon(onPressed: ()async{
              await AuthService().signOut();
            },
                icon: Icon(
                   Icons.person
                ),
                label: Text('logout')),
            InkWell(
              child: Icon(Icons.settings),
              onTap: (){
                 showSettings();
              },
            ),

          ],
        ),
        body: FoodAvailable()
      ),
    );
  }
}
