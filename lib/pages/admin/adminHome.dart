import 'package:alumni_tracking_system/helpline/appbars/adminAppBar.dart';
import 'package:alumni_tracking_system/helpline/drawers/adminDrawer.dart';
import 'package:alumni_tracking_system/pages/admin/studentDetails.dart';
import 'package:alumni_tracking_system/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {

  AdminHome({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _AdminHomePageState(auth, logoutCallback, userId);
}

class _AdminHomePageState extends State<AdminHome> {
  BaseAuth auth;
  VoidCallback logoutCallback;
  String userId;

  _AdminHomePageState( this.auth, this.logoutCallback, this.userId);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FirebaseUser currentUser;
  var email;
  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }
  
  void _loadCurrentUser() {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() { // call setState to rebuild the view
        this.currentUser = user;
      });
    });
  }

  String _email() {
    if (currentUser != null) {
      return currentUser.email;
    } else {
      return "no current user";
    }
  }
  
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    email = _email();
    return new Scaffold(
      drawer: AdminDrawerCodeOnly(
        email: this.email,
        userId: this.userId,
        auth : this.auth,
        logoutCallback: this.logoutCallback,
      ),
      appBar: CustomAdminAppBar(
        userId: this.userId,
        auth : this.auth,
        logoutCallback: this.logoutCallback,
      ),

          body : new SingleChildScrollView(
          child: Center(
          
            child : Column( 
              children: <Widget>[
              new Container(
                margin:  EdgeInsets.fromLTRB(5, 50, 0, 0),
                child: Row( 
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                  
                  new SizedBox(
                    width: width/2.2,
                    height: height/3,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0)
                      ),
                      onPressed : () => department("CSE"),
                      child: Text('CSE',
                        style: TextStyle (fontSize: 20.0),
                        textAlign: TextAlign.center
                      ),
                      padding: const EdgeInsets.all(25),
                      textColor: Colors.white,
                      color: Colors.green,   
                  ),),
                  new SizedBox(
                    width: width/2.2,
                    height: height/3,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0)
                      ),
                      onPressed: () => department("ECE"),
                      child: Text('ECE',
                      style: TextStyle (fontSize: 20.0),
                      ),
                    padding: const EdgeInsets.all(25),
                    textColor: Colors.black87,
                    color: Colors.yellow,   
                  ),),
              ],),),
              new Container(
                margin:  EdgeInsets.fromLTRB(5, 50, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                  
                  new SizedBox(
                    width: width/2.2,
                    height: height/3,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0)
                      ),
                      onPressed:() => department("IT"),
                      child: Text('IT',
                      style: TextStyle (fontSize: 20.0)
                      ),
                    padding: const EdgeInsets.all(25),
                    textColor: Colors.white,
                    color: Colors.blue,   
                  ),),
                  new SizedBox(
                    width: width/2.2,
                    height: height/3,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0)
                      ),
                      onPressed:() => department("EEE"),
                      child: Text('EEE',
                      style: TextStyle (fontSize: 20.0),
                      ),
                    padding: const EdgeInsets.all(25),
                    textColor: Colors.white,
                    color: Colors.pink,   
                  ),),
              ],),),
            ],),
            )
      
          )
        );
      }
      BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(),
  );
  }
  department(var dept) {
    widget.auth.getCurrentUser();
    print("Dept : " + dept);
    Navigator.push(context, MaterialPageRoute(builder: (context) => StudentDetails(
        email : this.email,
        dept : dept,
        userId: this.userId,
        auth : this.auth,
        logoutCallback: this.logoutCallback,
    )));
  }
}