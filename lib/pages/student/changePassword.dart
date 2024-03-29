import 'package:alumni_tracking_system/helpline/appbars/appbar.dart';
import 'package:alumni_tracking_system/helpline/drawers/drawer.dart';
import 'package:alumni_tracking_system/models/student.dart';
import 'package:alumni_tracking_system/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key key, this.student, this.auth, this.userId, this.logoutCallback})
      : super(key: key);
  final Student student;
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  @override
  _ChangePasswordPageState createState() => new _ChangePasswordPageState(student, auth, logoutCallback, userId);
}

class _ChangePasswordPageState extends State<ChangePassword> {
  Student student;
  BaseAuth auth;
  VoidCallback logoutCallback;
  String userId;

  _ChangePasswordPageState(this.student,this.auth, this.logoutCallback, this.userId);
  
  final databaseReference = FirebaseDatabase.instance.reference();
  String password1, password2;
  final FirebaseAuth firebaseauth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
  } 

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
      body: Center(
          child : Column(
          children: <Widget>[
          
          Container(
            padding: EdgeInsets.only(top : 200, left: 20.0, right: 20.0),
            child : Text("Mail will be sent to your registered email to reset password", style: TextStyle(fontSize: 20),),

          ),
             SizedBox(height: 20,),
            RaisedButton(
              onPressed: change,
              child: Text('Send password reset mail',
                style: TextStyle (fontSize: 20.0),
              ),
              padding: const EdgeInsets.all(20),
                    textColor: Colors.white,
                    color: Colors.green,   
            ),
          ],
        ) 
      )
    );
  }
    alertcalled(BuildContext context) {
    return Alert(context: context, title: 'Check your Mail!').show();
  }

  change() async {
    try {
      var email = student.email;
        await widget.auth.changePassword(email);
        alertcalled(context);
        } catch (e) {
            print(e);
        }
  }
  
}