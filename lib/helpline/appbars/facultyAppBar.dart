import 'package:alumni_tracking_system/services/authentication.dart';
import 'package:flutter/material.dart';
class CustomFacultyAppBar extends StatefulWidget with PreferredSizeWidget{
 CustomFacultyAppBar({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _CustomFacultyAppBar(auth, logoutCallback, userId);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomFacultyAppBar extends State<CustomFacultyAppBar> {
  BaseAuth auth;
  VoidCallback logoutCallback;
  String userId;
  _CustomFacultyAppBar(this.auth, this.logoutCallback, this.userId);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    super.initState();
  }
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("");
  
  @override 
  Widget build(BuildContext context) {
    //print(this.userId);
    return AppBar(
        backgroundColor: Colors.lightBlue,
        actions: <Widget> [
          
          InkWell(
            onTap: (){},
            child: SizedBox(
              width: 40.0,
              
            ),
          ),
          IconButton(icon: Icon(Icons.search),
            onPressed: (){
              setState(() {
                if(this.cusIcon.icon == Icons.search){
                  this.cusIcon = Icon(Icons.cancel);
                  this.cusSearchBar = TextField(
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search",
                      hintStyle: TextStyle(
                        color:Colors.white,
                        fontSize:16.0,
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  );

                }
                else {
                  this.cusIcon = Icon(Icons.search);
                  this.cusSearchBar = Text("");

                }
              });
            },),
            new FlatButton(
                child: Icon(Icons.exit_to_app, color: Colors.white,),
                onPressed: signOut)
        ],
        titleSpacing: 0.0,
        title: cusSearchBar,
      );
  }
   signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
      Navigator.popUntil(context, ModalRoute.withName('/'));
    } catch (e) {
      print(e);
    }
  }
}