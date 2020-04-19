import 'package:alumni_tracking_system/pages/admin/adminChangePass.dart';
import 'package:alumni_tracking_system/pages/admin/adminHome.dart';
import 'package:alumni_tracking_system/pages/admin/provideAuth.dart';
import 'package:alumni_tracking_system/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminDrawerCodeOnly extends StatefulWidget {
 AdminDrawerCodeOnly({Key key,this.email, this.auth, this.userId, this.logoutCallback})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId, email;

  @override
  State<StatefulWidget> createState() => new _AdminDrawerCodeOnly(email, auth, logoutCallback, userId);
}

class _AdminDrawerCodeOnly extends State<AdminDrawerCodeOnly> {
  BaseAuth auth;
  VoidCallback logoutCallback;
  String userId, email;

  _AdminDrawerCodeOnly(this.email, this.auth, this.logoutCallback, this.userId);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FirebaseUser currentUser;
@override
  void initState() {
    super.initState();
  }
  
  @override 
  Widget build(BuildContext context) {
    return new Drawer(
          child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container (
              height : 100,
              child : DrawerHeader(
              child: Text("Admin", style : TextStyle(
                fontSize: 15,
                color: Colors.black,
              )),
                    //Text(student.studentName),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
              ),
            ),
            ),
            CustomListTile(Icons.home, "Home", () => Navigator.push(context, MaterialPageRoute(builder: (context) => AdminHome(
              userId: this.userId,
              auth : this.auth,
              logoutCallback: this.logoutCallback,
            )))),
            CustomListTile(Icons.person, "Provide Auth", () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProvideAuth(
              userId: this.userId,
              auth : this.auth,
              logoutCallback: this.logoutCallback,
            )))),
            // CustomListTile(Icons.vpn_key, "Change password", () => Navigator.push(context, MaterialPageRoute(builder: (context) => AdminChangePassword(
            //   email: this.email,
            //   userId: this.userId,
            //   auth : this.auth,
            //   logoutCallback: this.logoutCallback,
            // )))),
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
