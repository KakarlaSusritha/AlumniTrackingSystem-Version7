import 'package:alumni_tracking_system/helpline/appbars/appbar.dart';
import 'package:alumni_tracking_system/helpline/drawers/drawer.dart';
import 'package:alumni_tracking_system/models/student.dart';
import 'package:alumni_tracking_system/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key key,this.student, this.auth, this.userId, this.logoutCallback})
      : super(key: key);
  final Student student;
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _Profile(student, auth, logoutCallback, userId);
}

  class _Profile extends State<Profile> {
    Student student;
    BaseAuth auth;
  VoidCallback logoutCallback;
  String userId;
  

  _Profile(this.student,this.auth, this.logoutCallback, this.userId);
  
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  
  final TextStyle whiteText = TextStyle(
    color: Colors.white,
  );
  final TextStyle greyTExt = TextStyle(
    color: Colors.grey.shade400,
  );

    
  @override
  Widget build(BuildContext context) {
    var name = student.studentName,
        personalEmail = student.personalEmail, 
        email = student.email, 
        placed = student.placed, 
        package = student.package,
        rollNum = student.rollNo,
        mobileNumber = student.mobileNumber,
        higheredu = student.higherEdu;

    return Scaffold(
      
      drawer: DrawerCodeOnly(
        student : this.student,
        auth : this.auth,
        logoutCallback :  this.logoutCallback,
        userId :  this.userId
      ),
      appBar: CustomAppBar(
        auth : this.auth,
        logoutCallback :  this.logoutCallback,
        userId :  this.userId
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Colors.green,
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            color: Colors.white,
          ),
                  child: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30.0),
                Row(
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color : Colors.black87,width: 2.0,),
                      ),
                      child : new Icon(
              Icons.person,
              color: Colors.grey,
              size: 50,
            )),
                    
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("$name", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color : Colors.black87,
                          ),),
                          Text("$email",style: TextStyle(
                            color: Colors.grey.shade900,
                          ),),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20.0),
                ListTile(
                  title: Text("Roll number",style: TextStyle(color : Colors.black87,),),
                  subtitle: Text("$rollNum",style: TextStyle(color: Colors.grey.shade600,)),
                  
                ),
                ListTile(
                  title: Text("Personal email",style: TextStyle(color : Colors.black87,),),
                  subtitle: Text("$personalEmail",style: TextStyle(color: Colors.grey.shade600,)),
                ),
                ListTile(
                  title: Text("Mobile number",style: TextStyle(color : Colors.black87,)),
                  subtitle: Text("$mobileNumber",style: TextStyle(color: Colors.grey.shade600,)),
                
                ),
                ListTile(
                  title: Text("Higher education",style: TextStyle(color : Colors.black87,)),
                  subtitle: Text("$higheredu",style: TextStyle(color: Colors.grey.shade600,)),
                
                ),
                ListTile(
                  title: Text("Company placed",style: TextStyle(color : Colors.black87,)),
                  subtitle: Text("$placed",style: TextStyle(color: Colors.grey.shade600,)),
                 
                ),
                ListTile(
                  title: Text("Package",style: TextStyle(color : Colors.black87,)),
                  subtitle: Text("$package",style: TextStyle(color: Colors.grey.shade600,)),
               
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}