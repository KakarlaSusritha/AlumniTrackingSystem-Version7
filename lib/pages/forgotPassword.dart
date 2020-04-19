
import 'package:alumni_tracking_system/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key key, this.auth,})
      : super(key: key);
  final BaseAuth auth;
  @override
  _ForgotPasswordPageState createState() => new _ForgotPasswordPageState(auth);
}

class _ForgotPasswordPageState extends State<ForgotPassword> {
  BaseAuth auth;

  _ForgotPasswordPageState(this.auth);
  
  final databaseReference = FirebaseDatabase.instance.reference();
  String _email;
  final FirebaseAuth firebaseauth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  } 

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      
      body: Form(
        key: _formKey,
          child : Column(
          children: <Widget>[
          
          Container(
            padding: EdgeInsets.only(top : 200, left: 20.0, right: 20.0),
            child : Text("Mail will be sent to your registered email to reset password", style: TextStyle(fontSize: 20),),

          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child : Column(
                  children: <Widget>[
            TextFormField(
              validator: (input) => input.isEmpty ? 'Email can\'t be empty' : null,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))
              ),
              onSaved: (input) => _email = input,
            ),
                  ],
            )
          ),
             SizedBox(height: 20,),
            RaisedButton(
              onPressed: () {
                change();
              },
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
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try {
          await widget.auth.signUp(_email, "webcap");
        } catch (e) {
          try {
            await widget.auth.changePassword(_email);
            alertcalled(context);
          } catch(e) {
            print(e);
          }
          
        }
    }
  }
  
}