import 'package:alumni_tracking_system/models/student.dart';
import 'package:alumni_tracking_system/pages/student/home.dart';
import 'package:alumni_tracking_system/pages/student/profile.dart';
import 'package:alumni_tracking_system/pages/student/settings.dart';
import 'package:alumni_tracking_system/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerCodeOnly extends StatefulWidget {
 DrawerCodeOnly({Key key, this.student, this.auth, this.userId, this.logoutCallback})
      : super(key: key);
  final Student student;
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _DrawerCodeOnly(student, auth, logoutCallback, userId);
}

class _DrawerCodeOnly extends State<DrawerCodeOnly> {
  Student student;
  BaseAuth auth;
  VoidCallback logoutCallback;
  String userId;

  _DrawerCodeOnly(this.student,this.auth, this.logoutCallback, this.userId);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FirebaseUser currentUser;
@override
  void initState() {
    super.initState();
   // _loadCurrentUser();
  }

  // void _loadCurrentUser() {
  //   FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
  //     setState(() { // call setState to rebuild the view
  //       this.currentUser = user;
  //     });
  //   });
  // }

  // String _email() {
  //   if (currentUser != null) {
  //     return currentUser.email;
  //   } else {
  //     return "no current user";
  //   }
  // }
  
  @override 
  Widget build(BuildContext context) {
   var name = student.studentName;
    return new Drawer(
          child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container (
              height : 100,
              child : DrawerHeader(
              child: Text("$name", style : TextStyle(
                fontSize: 15,
                color: Colors.black,
              )),
                    //Text(student.studentName),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
              ),
            ),
            ),
            CustomListTile(Icons.home, "Home", () => Navigator.push(context, MaterialPageRoute(builder: (context) => Home(
              userId: this.userId,
              auth : this.auth,
              logoutCallback: this.logoutCallback,
            )))),
            CustomListTile(Icons.person, "Profile", () => Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(
              student : this.student,
              userId: this.userId,
              auth : this.auth,
              logoutCallback: this.logoutCallback,
            )))),
            CustomListTile(Icons.settings, "Settings", () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(
              student : this.student,
              userId: this.userId,
              auth : this.auth,
              logoutCallback: this.logoutCallback,
            )))),
            //CustomListTile(Icons.exit_to_app, "Log out",=>  widget.auth.signOut();
          ],
        ),
      );    
 }  
}

class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom : BorderSide(color: Colors.grey.shade200))
        ),
        child: InkWell(
          splashColor: Colors.grey,
          onTap: onTap,
          child : Container(
            height: 40,
            child: Row (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children : <Widget> [
                Row(
                  children : <Widget> [
                    Icon(icon),
                    Padding (
                      padding: const EdgeInsets.all(5),
                      child: Text(text, style : TextStyle(
                      fontSize: 17
                    )),
                    )
                    
                  ]
                ),
                
                Icon(Icons.arrow_right)
              ]
            ),
          )
        ),
      ),
    );
  }
}
