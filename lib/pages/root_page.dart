import 'package:alumni_tracking_system/models/faculty.dart';
import 'package:alumni_tracking_system/models/student.dart';
import 'package:alumni_tracking_system/pages/admin/adminHome.dart';
import 'package:alumni_tracking_system/pages/faculty/facultyHome.dart';
import 'package:alumni_tracking_system/pages/login_signup_page.dart';
import 'package:alumni_tracking_system/pages/student/home.dart';
import 'package:alumni_tracking_system/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";
  FirebaseUser currentUser;
  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
        authStatus =
            user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }  

  void loginCallback() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
  Student student  = new Student();
  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new LoginSignupPage(
          auth: widget.auth,
          loginCallback: loginCallback,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          if (_userId == "JAzcZwQOwuSEV5pNt9IBJgt9OJ52") {
            return AdminHome(
              userId: _userId,
              auth: widget.auth,
              logoutCallback: logoutCallback,
            );
          } else {
           
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
  bool isNumeric(String s) {
 if (s == null) {
   return false;
 }
 return double.tryParse(s) != null;
}
  _loadCurrentUser();
  var email = _email();
  var check = isNumeric(email.toString().substring(0,2));
  if (check) {
    return new Home(
      userId: _userId,
      auth: widget.auth,
      logoutCallback: logoutCallback,
    );
  } else {
    return new FacultyHome(
      userId: _userId,
      auth: widget.auth,
      logoutCallback: logoutCallback,
    );
  }
                  
          }
         } else
                  return buildWaitingScreen();
                break;
              default:
                return buildWaitingScreen();
            }
          }
        }
        