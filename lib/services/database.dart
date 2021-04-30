import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foody_help/models/hostels.dart';
import 'package:foody_help/models/user.dart';
import 'package:foody_help/services/auth.dart';


class DatabaseService{

  final _auth = AuthService();

  /// collection
  final CollectionReference hostelCollection = FirebaseFirestore.instance.collection('hostelInfo');
  final String uid;
  DatabaseService({this.uid});


  List<Hostel> _hostelFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) =>
    Hostel(
      Hostel_number: doc.data()['Hostel_number']?? " ",
      Hostel_name: doc.data()['Hostel_name']?? " ",
      Contact_number: doc.data()['Contact_number']?? " ",
      Address: doc.data()['Address']?? null,
      Food_left: doc.data()['Food_left']?? " ",
      Updated_at: doc.data()['Updated_at']?? "N/A",
    )).toList();
  }

  Future updateHostelData(String Hostel_number, String Hostel_name, String Contact_number, String Address, String Food_left) async{
    DateTime now = DateTime.now();
    String createdAt = "${now.day.toString()}- ${now.month.toString()}- ${now.year.toString().padLeft(2, '0')} ${now.hour.toString()}:${now.minute.toString()}";
    return await hostelCollection.doc(uid).set({
      'Hostel_number': Hostel_number,
      'Hostel_name': Hostel_name,
      'Contact_number': Contact_number,
      'Address': Address,
      'Food_left': Food_left,
      'Updated_at': createdAt
    });
  }


  Stream<List<Hostel>> get hostels {
    return hostelCollection.snapshots().map(_hostelFromSnapshot);
  }

  User_hostel _user_hostelfromSnapshot(DocumentSnapshot snapshot){
    return User_hostel(
      uid: uid,
      Hostel_number: snapshot.data()['Hostel_number'],
      Hostel_name: snapshot.data()['Hostel_name'],
      Contact_number: snapshot.data()['Contact_number'],
      Address: snapshot.data()['Address'],
      Food_left: snapshot.data()['Food_left'],
      Updated_at: snapshot.data()['Updated_at']
    );
  }

  Stream<User_hostel> get user_hostel {
    return hostelCollection.doc(uid).snapshots().map(_user_hostelfromSnapshot);
  }

  Future deleteData() async {
    await hostelCollection.doc(uid).delete();
    return await _auth.signOut();
  }
}