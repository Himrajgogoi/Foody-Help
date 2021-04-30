import 'package:flutter/material.dart';
import 'package:foody_help/models/hostels.dart';
import 'package:url_launcher/url_launcher.dart';


class BuildTile extends StatelessWidget {
  final Hostel hostel;
  BuildTile({this.hostel});
  String dropdownValue=" ";


  @override
  Widget build(BuildContext context) {
       return Padding(
         padding: EdgeInsets.all(8.0),
         child: Card(
           color: Colors.grey[800],
           margin: EdgeInsets.fromLTRB(15, 0, 15, 5),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               SizedBox(height: 10.0),
               ExpansionTile(title: Text("Hostel ${hostel.Hostel_number}",
               style: TextStyle(color: Colors.white),),
                leading: _radioButton(),
               children: [
                 SizedBox(height: 10.0),
                 Padding(
                   padding:  EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("Hostel name",
                         style: TextStyle(color: Colors.white),),
                       Text("${hostel.Hostel_name}",
                         style: TextStyle(color: Colors.white),),
                     ],
                   ),
                 ),
                 Divider(height: 10.0, thickness: 2.0, endIndent: 25.0, indent: 25.0,),
                 Text("Contact Number",
                   style: TextStyle(color: Colors.white),),
                 Divider(height: 10.0, thickness: 2.0,endIndent: 25.0, indent: 25.0,),
                 Padding(
                   padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
                   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text("${hostel.Contact_number}",
                       style: TextStyle(color: Colors.white),),
                     InkWell(
                       child: Icon(Icons.phone, color: Colors.blueAccent,),
                       onTap: () async {
                           await launch("tel://${hostel.Contact_number}");
                       },
                     ),

                   ],),
                 ),
                 Divider(height: 10.0, thickness: 2.0,endIndent: 25.0, indent: 25.0,),

                 Padding(
                   padding:  EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Expanded(
                         flex: 2,
                         child: Text("Food Available",
                           style: TextStyle(color: Colors.white),),
                       ),
                       Expanded(
                         flex: 4,
                         child: Text("${hostel.Food_left}",
                           overflow: TextOverflow.ellipsis,
                           maxLines: 2,
                           style: TextStyle(color: Colors.white),),
                       ),
                     ],
                   ),
                 ),
                 Divider(height: 10.0, thickness: 2.0,endIndent: 25.0, indent: 25.0,),

                 Padding(
                   padding:  EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("Updated On",
                         style: TextStyle(color: Colors.white),),
                       Text("${hostel.Updated_at}",
                         style: TextStyle(color: Colors.white),),
                     ],
                   ),
                 ),
                 SizedBox(height: 10.0,)

               ],)
             ],
           ),
         )
       );
  }

  Widget _radioButton() {
    if(hostel.Food_left.isNotEmpty && hostel.Food_left != "N/A"){
      return Icon( Icons.radio_button_checked, color: Colors.yellowAccent,);
    }
    else{
      return Icon(Icons.radio_button_unchecked, color: Colors.yellowAccent,);
    }
  }
}
