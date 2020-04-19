
import 'package:alumni_tracking_system/helpline/appbars/adminAppBar.dart';
import 'package:alumni_tracking_system/helpline/drawers/adminDrawer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:alumni_tracking_system/services/authentication.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class ProvideAuth extends StatefulWidget {

  ProvideAuth({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _ProvideAuthPageState(auth, logoutCallback, userId);
}

class _ProvideAuthPageState extends State<ProvideAuth> {
  BaseAuth auths;
  VoidCallback logoutCallback;
  String userId;

  _ProvideAuthPageState( this.auths, this.logoutCallback, this.userId);
  FirebaseUser currentUser;
  @override
  void initState() {
    super.initState();
  }
final databaseReference = FirebaseDatabase.instance.reference();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String sheetName;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
      drawer: AdminDrawerCodeOnly(
        auth: this.auths,
        userId: this.userId,
        logoutCallback: this.logoutCallback,
      ),
      appBar: CustomAdminAppBar(auth: this.auths, userId: this.userId, logoutCallback: this.logoutCallback),
      body: Form (
        key: _formKey,
        child : SingleChildScrollView(
        child: Column(
          
          children: <Widget>[
            
          Container(
            padding: EdgeInsets.all(30),
            child : Column(
                  children: <Widget>[
            TextFormField(
              validator: (input) => input.isEmpty ? 'sheet name can\'t be empty' : null,
              decoration: InputDecoration(
                labelText: 'Enter sheet name',
                labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))
              ),
              onSaved: (input) => sheetName = input,
            ),
                  ],
            )
          ),
          
            RaisedButton(
              onPressed: createUsersAuth,
              child: Text('ADD',
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
  alertcalled(BuildContext context) {
    return Alert(context: context, title: 'Done!').show();
  }
  msg() {
    return Alert(context: context, title: 'Sheet name not found.').show();
  }
    void createUsersAuth(){
      if(_formKey.currentState.validate()){
      _formKey.currentState.save();
        
      databaseReference.once().then((DataSnapshot snapshot) {
      var a = snapshot.value;
      List b = a[sheetName];
      if (b == null) {
        msg();
      } else {
        for (int i = 1; i < b.length; i++) {
        try{
       widget.auth.signUp(b[i]["Email"], "webcap");
        } catch(e) {
          print(e.message);        }
      }
        alertcalled(context);
      }
      
    });
      }
      
  }

}

//}
//   final databaseReference = FirebaseDatabase.instance.reference();
//   String sheetName;
//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//         appBar: AppBar(
//             title: Text('Welcome Admin'),
//             ),
//         body: Center(
//             child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[

//                   // RaisedButton(
//                   //     child: Text('Create Record'),
//                   //     onPressed: () {
//                   //       createRecord();
//                   //     },
//                   // ),  

//                  Container(
//             padding: EdgeInsets.only(left: 20.0, right: 20.0),
//             child : Column(
//                   children: <Widget>[
//             TextFormField(
//               validator: (input) => input.isEmpty ? 'Email can\'t be empty' : null,
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 labelStyle: TextStyle(
//                               fontFamily: 'Montserrat',
//                               fontWeight: FontWeight.bold,
//                               color: Colors.grey),
//                           focusedBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.green))
//               ),
//               onSaved: (input) => sheetName = input,
//             ),
//                   ],
//             )
//           ),
//                   RaisedButton(
//                       child: Text('ADD'),
//                       onPressed: () {
//                         createUsersAuth();
//                       },
//                   ),
//                   // RaisedButton(
//                   //     child: Text('Udate Record'),
//                   //     onPressed: () {
//                   //       updateData();
//                   //     },
//                   // ),
//                   // RaisedButton(
//                   //     child: Text('Delete Record'),
//                   //     onPressed: () {
//                   //       deleteData();
//                   //     },
//                   // ),
//                 ],
//             )
//         ), //center
//     );
//   }


//   void updateData(){

//   }

//   void deleteData(){
    
//   }
// }