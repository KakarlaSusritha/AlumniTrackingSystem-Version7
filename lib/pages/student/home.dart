import 'package:alumni_tracking_system/helpline/appbars/appbar.dart';
import 'package:alumni_tracking_system/helpline/drawers/drawer.dart';
import 'package:alumni_tracking_system/models/student.dart';
import 'package:alumni_tracking_system/pages/student/details.dart';
import 'package:alumni_tracking_system/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  Home({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState(auth, logoutCallback, userId);
}

class _HomePageState extends State<Home> {
  BaseAuth auth;
  VoidCallback logoutCallback;
  String userId;

  _HomePageState( this.auth, this.logoutCallback, this.userId);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FirebaseUser currentUser;
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
  
  Student student = new Student();
  @override
  Widget build(BuildContext context) {
   // print(auth.email);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var userMail = _email();
    if (userMail != "no current user") {
  
      var year = userMail.toString().substring(0,2);
      var sheetName = "CSE-20" + year;
      student.sheetName = sheetName.toString();
          FirebaseDatabase.instance.reference()
      .child(sheetName)
      .orderByChild("Email")
      .equalTo(userMail)
      .once().then((DataSnapshot snapshot){
        Map<dynamic, dynamic> values = snapshot.value;
        student.key = values.keys.first;
        Map<dynamic, dynamic> a = values.values.toList()[0];

        student.email = a["Email"];
        student.studentName = a["Name"];
        student.mobileNumber = a['MobileNum'];
        student.rollNo = a['Rollno'];
        student.personalEmail = a['PersonalEmail'];
        student.placed = a['Company'];
        student.package = a['Package'];
        student.higherEdu = a['HigherEdu'];
        });
    }
    
    return new Scaffold(
      drawer: DrawerCodeOnly(
        student : this.student,
        userId: this.userId,
        auth : this.auth,
        logoutCallback: this.logoutCallback,
      ),
      appBar: CustomAppBar(
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => Details(
      student: this.student,
        dept : dept,
        userId: this.userId,
        auth : this.auth,
        logoutCallback: this.logoutCallback,
    )));
  }
}