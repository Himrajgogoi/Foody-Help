import 'package:flutter/material.dart';
import 'package:foody_help/models/user.dart';
import 'package:foody_help/services/database.dart';
import 'package:foody_help/shared/textdecoration.dart';
import 'package:provider/provider.dart';


class HostelSettings extends StatefulWidget {
  @override
  _HostelSettingsState createState() => _HostelSettingsState();
}

class _HostelSettingsState extends State<HostelSettings> {

  final _formkey = GlobalKey<FormState>();
  String Hostel_number;
  String Hostel_name;
  String Contact_number;
  String Dp;
  String Food_left;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User_>(context);
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Settings',
        style: TextStyle(
          color: Colors.white
        ),)
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
        child: StreamBuilder<User_hostel>(
          stream: DatabaseService(uid: user.uid).user_hostel,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              User_hostel hostel = snapshot.data;
              return SingleChildScrollView(
                child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        SizedBox(height: 10.0,),
                        Text("Enter the food left",
                          style: TextStyle(color: Colors.white),),
                        SizedBox(height: 10.0,),
                        TextFormField(
                          decoration: textDecoration.copyWith(hintText: 'Food Left or type N/A'),
                          initialValue: Food_left?? hostel.Food_left,
                          validator:(val)=> val.isEmpty? "Enter valid data": null,
                          onChanged: (val){
                            setState(() {
                              Food_left = val;
                            });
                          },
                        ),
                        Divider(
                          height: 30.0, thickness: 1.0, endIndent: 50.0, indent: 20.0, color: Colors.blueAccent,
                        ),
                        Text("Enter the hostel number",
                          style: TextStyle(color: Colors.white),),
                        SizedBox(height: 10.0,),
                        TextFormField(
                          decoration: textDecoration.copyWith(hintText: 'Hostel Number'),
                          initialValue: hostel.Hostel_number,
                          validator:(val)=> val.isEmpty? "Enter valid data": null,
                          onChanged: (val){
                            setState(() {
                              Hostel_number = val;
                            });
                          },
                        ),
                        SizedBox(height: 10.0,),
                        Text("Enter the hostel name",
                          style: TextStyle(color: Colors.white),),
                        SizedBox(height: 10.0,),
                        TextFormField(
                          decoration: textDecoration.copyWith(hintText: 'Hostel Name'),
                          initialValue: hostel.Hostel_name,
                          validator:(val)=> val.isEmpty? "Enter valid data": null,
                          onChanged: (val){
                            setState(() {
                              Hostel_name = val;
                            });
                          },
                        ),
                        SizedBox(height: 10.0,),
                        Text("Enter the contact number",
                          style: TextStyle(color: Colors.white),),
                        SizedBox(height: 10.0,),
                        TextFormField(
                          decoration: textDecoration.copyWith(hintText: 'Contact Number'),
                          initialValue: hostel.Contact_number,
                          validator:(val)=> val.isEmpty? "Enter valid data": null,
                          onChanged: (val){
                            setState(() {
                              Contact_number = val;
                            });
                          },
                        ),
                        SizedBox(height: 10.0,),
                        Text("Enter the Address",
                          style: TextStyle(color: Colors.white),),
                        SizedBox(height: 10.0,),
                        TextFormField(
                          decoration: textDecoration.copyWith(hintText: 'Dp'),
                          initialValue: hostel.Address,
                          validator:(val)=> val.isEmpty? "Enter valid data": null,
                          onChanged: (val){
                            setState(() {
                              Dp = val;
                            });
                          },
                        ),
                        TextButton(onPressed: () async {
                          if(_formkey.currentState.validate()){
                            await DatabaseService(uid: user.uid).updateHostelData(Hostel_number??hostel.Hostel_number, Hostel_name??hostel.Hostel_name,
                                Contact_number??hostel.Contact_number, Dp??hostel.Address, Food_left??hostel.Food_left);
                          }
                         }, child: Text("update"),
                         ),
                        SizedBox(height: 10.0,),
                      ],
                    )
                ),
              );
            }
            else{
              return Center(
                child: Text("An error occured.",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0
                ),),
              );
            }

          }
        )
      ),
    );
  }
}
