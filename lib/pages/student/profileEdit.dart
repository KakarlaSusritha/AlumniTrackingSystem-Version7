import 'package:alumni_tracking_system/helpline/appbars/appbar.dart';
import 'package:alumni_tracking_system/helpline/drawers/drawer.dart';
import 'package:alumni_tracking_system/models/student.dart';
import 'package:alumni_tracking_system/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ProfileEdit extends StatefulWidget {
  ProfileEdit({Key key,this.student,  this.auth, this.userId, this.logoutCallback})
      : super(key: key);
  final Student student;
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _ProfileEdit(student, auth, logoutCallback, userId);
}

  class _ProfileEdit extends State<ProfileEdit> {
    Student student;
    BaseAuth auth;
  VoidCallback logoutCallback;
  String userId;


  var personalEmail, mobnum, higheredu, company, package;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  _ProfileEdit(this.student, this.auth, this.logoutCallback, this.userId);
  
    @override 
    Widget build(BuildContext context) {
      return new Scaffold(
        drawer: new DrawerCodeOnly(
            student: this.student,
            userId: this.userId,
            auth : this.auth,
            logoutCallback: this.logoutCallback,
        ),
        appBar: CustomAppBar(
            userId: this.userId,
            auth : this.auth,
            logoutCallback: this.logoutCallback,
        ),
        body: Form (
            key: _formKey,
            child : SingleChildScrollView(
                child: Column(
          
          children: <Widget>[
            SizedBox(height: 70.0),
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child : Column(
                  children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Personal mail',
                labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))
              ),
              onSaved: (input) => personalEmail = input,
            ),
                  ],
            )
          ),
          Container(
            padding: EdgeInsets.only(top : 10,left: 20.0, right: 20.0, bottom:10),
            child : Column(
                  children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Mobile number',
                labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))
              ),
              onSaved: (input) => mobnum = input,
            ),
                  ],
            )
          ),
          Container(
            padding: EdgeInsets.only(top : 10,left: 20.0, right: 20.0, bottom:10),
            child : Column(
                  children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: "Higher Education",
                labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))
              ),
              onSaved: (input) => higheredu = input,
              obscureText: true,
            ),
                  ],
            )
          ),
          Container(
            padding: EdgeInsets.only(top : 10,left: 20.0, right: 20.0, bottom:10),
            child : Column(
                  children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Company',
                labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))
              ),
              onSaved: (input) => company = input,
            ),
                  ],
            )
          ),
          Container(
            padding: EdgeInsets.only(top : 10,left: 20.0, right: 20.0, bottom:10),
            child : Column(
                  children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Package',
                labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))
              ),
              onSaved: (input) => package = input,
            ),
                  ],
            )
          ),
                    SizedBox(height: 30.0),
            RaisedButton(
              onPressed: update,
              child: Text('Update',
                style: TextStyle (fontSize: 20.0),
              ),
              shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
              padding: const EdgeInsets.fromLTRB(100, 15, 100, 15),
                    textColor: Colors.white,
                    color: Colors.green,   
            ),
            SizedBox(height: 20.0),
          ],
        ) 
      ),
      )
    );
    }
    update() {
      if(_formKey.currentState.validate()){
      _formKey.currentState.save();

        if (personalEmail != "") {
          FirebaseDatabase.instance.reference()
          .child(student.sheetName).child(student.key).child("PersonalEmail").set(personalEmail);
        } if (mobnum != "") {
          FirebaseDatabase.instance.reference()
          .child(student.sheetName).child(student.key).child("MobileNum").set(mobnum);
        } 
        if (higheredu != "") {
          FirebaseDatabase.instance.reference()
          .child(student.sheetName).child(student.key).child("PersonalEmail").set(higheredu);
        } 
        if (company != "") {
          FirebaseDatabase.instance.reference()
          .child(student.sheetName).child(student.key).child("Placed").set(company);
        }
        if (package != null) {
          FirebaseDatabase.instance.reference()
          .child(student.sheetName).child(student.key).child("Package").set(package);
        }
      }
    }
  }