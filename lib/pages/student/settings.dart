import 'package:alumni_tracking_system/helpline/appbars/appbar.dart';
import 'package:alumni_tracking_system/helpline/drawers/drawer.dart';
import 'package:alumni_tracking_system/models/student.dart';
import 'package:alumni_tracking_system/pages/student/changePassword.dart';
import 'package:alumni_tracking_system/pages/student/profileEdit.dart';
import 'package:alumni_tracking_system/services/authentication.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key,this.student, this.auth, this.userId, this.logoutCallback})
      : super(key: key);
  final Student student;
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _SettingsPage(student, auth, logoutCallback, userId);
}

  class _SettingsPage extends State<SettingsPage> {
    Student student;
    BaseAuth auth;
  VoidCallback logoutCallback;
  String userId;

  _SettingsPage(this.student, this.auth, this.logoutCallback, this.userId);

  final TextStyle whiteText = TextStyle(
    color: Colors.white,
  );
  final TextStyle greyTExt = TextStyle(
    color: Colors.grey.shade400,
  );
  
  @override
  Widget build(BuildContext context) {
    var whiteBoldText = TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    );
    var name = student.studentName,
        personalEmail = student.personalEmail, 
        email = student.email, 
        placed = student.placed, 
        package = student.package,
        rollNum = student.rollNo,
        mobileNumber = student.mobileNumber;
    return Scaffold(
      drawer: DrawerCodeOnly(
        student: this.student,
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
                        // image: DecorationImage(
                        //   image: CachedNetworkImageProvider(avatars[1]),
                        //   fit: BoxFit.cover,
                        // ),
                        border: Border.all(color : Colors.black87,width: 2.0,),
                        
                      ),
                      child : new Icon(
              Icons.person,
              color: Colors.grey,
              size: 50,
            )
                    ),
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
                  title: Text("Profile Settings",style: TextStyle(color : Colors.black87,),),
                  subtitle: Text("$name",style: TextStyle(color: Colors.grey.shade600,)),
                  trailing: Icon(Icons.keyboard_arrow_right,color: Colors.grey.shade400,),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEdit(
                      student : this.student,
                      userId: this.userId,
                      auth : this.auth,
                      logoutCallback: this.logoutCallback,
                    )));
                  },
                ),
                ListTile(
                  title: Text("Change Password",style: TextStyle(color : Colors.black87,)),
                  trailing: Icon(Icons.keyboard_arrow_right,color: Colors.grey.shade400,),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword(
                      student : this.student,
                      userId: this.userId,
                      auth : this.auth,
                      logoutCallback: this.logoutCallback,
                    )));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}