
import 'package:alumni_tracking_system/pages/admin/adminHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
class LoginPage extends StatefulWidget {
  const LoginPage();
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final databaseReference = FirebaseDatabase.instance.reference();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
      
      body: Form (
        key: _formKey,
        child : SingleChildScrollView(
        child: Column(
          
          children: <Widget>[
            Container (
            margin: EdgeInsets.only(top : 100.0, bottom : 30),
            child: Column (
            children: <Widget>[
              new Image(
            image: new AssetImage("assets/bvrithlogo.png"),
            fit: BoxFit.cover,
            height: 125,
          ),
              ]
            )
          ),
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
          Container(
            padding: EdgeInsets.only(top : 10,left: 20.0, right: 20.0, bottom:10),
            child : Column(
                  children: <Widget>[
            TextFormField(
              validator: (input) => input.isEmpty ? 'Password can\'t be empty' : null,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))
              ),
              onSaved: (input) => _password = input,
              obscureText: true,
            ),
                  ],
            )
          ),
             Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(top : 20.0,left: 20.0, right: 20.0),
                      child: InkWell(
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
            RaisedButton(
              onPressed: logIn,
              child: Text('Log in',
                style: TextStyle (fontSize: 20.0),
              ),
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

  void logIn() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        if (_email == "admin" && _password == "admin123") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AdminHome()));
        } else {
          FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
        //  appAuth.login().then((result) {
              // if (result) {
                //  Navigator.of(context).pushNamed('/Home');
              // } 
            // });
        }
      }catch(e){
        print(e.message);
      }
    }
  }
}