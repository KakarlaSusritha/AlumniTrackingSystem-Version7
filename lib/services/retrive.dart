import 'package:firebase_database/firebase_database.dart';

get(var userId) {
  FirebaseDatabase.instance.reference()
      .child("CSE-2017")
      // .orderByChild("College email Id")
      // .equalTo(userId)
      .once().then((DataSnapshot snapshot){
        
        List<dynamic> values = snapshot.value;
       // print(values);
       var a;
        for (int i = 1; i < values.length; i++) {
         if (values[i]['Email'] == userId) {
            a = values[i];
            break;
          }
        }
       // print(a);
        return a;
        // print(a['Name']);
        // values = (values.values.toList())[0];
// print(values);
        // studentName = a['Name'];
        // mobileNumber = a['MobileNum'];
        // rollNo = a['Rollno'];
        // personalEmail = a['PersonalEmail'];
        // placed = a['Placed'];
        // package = a['Package'];
        // print(personalEmail);
      });
      
}