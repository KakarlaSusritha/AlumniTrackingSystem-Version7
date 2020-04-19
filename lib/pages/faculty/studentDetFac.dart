
import 'package:alumni_tracking_system/helpline/appbars/facultyAppBar.dart';
import 'package:alumni_tracking_system/helpline/drawers/facultyDrawer.dart';
import 'package:alumni_tracking_system/models/faculty.dart';
import 'package:alumni_tracking_system/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';


class StudDetails extends StatefulWidget {
 StudDetails({Key key, this.faculty, this.dept, this.auth, this.userId, this.logoutCallback})
      : super(key: key);
  final Faculty faculty;
  final String dept;
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _StudDetails(faculty, dept, auth, logoutCallback, userId);
}

class _StudDetails extends State<StudDetails> {
  Faculty faculty;
  String dept;
  BaseAuth auth;
  VoidCallback logoutCallback;
  String userId;

  _StudDetails(this.faculty,this.dept, this.auth, this.logoutCallback, this.userId);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final databaseReference = FirebaseDatabase.instance.reference();
  int _total = 360, totalDept = 0, _placed = 0, _notPlaced = 0, _currentValue = 2017;
  @override
  void initState() {
    super.initState();
    call(databaseReference);
    
  }       
        
        @override
          Widget build(BuildContext context) {
          var width = MediaQuery.of(context).size.width/2.2;
          var height = MediaQuery.of(context).size.height/4.5;
          
            return Scaffold(
               drawer: new FacultyDrawerCodeOnly(
                 faculty: this.faculty,
                 userId: this.userId,
            auth : this.auth,
            logoutCallback: this.logoutCallback,
               ),
               appBar: CustomFacultyAppBar(
                 userId: this.userId,
            auth : this.auth,
            logoutCallback: this.logoutCallback,
               ),
              body : new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new NumberPicker.integer(
                    initialValue: _currentValue,
                    minValue: 2012,
                    maxValue: 2017,
                    onChanged: (newValue) =>
                        setState(() {
                          _currentValue = newValue;
                          call(databaseReference);
                        })),
                new Text("Current number: $_currentValue"),
                new Container(
                    margin:  EdgeInsets.fromLTRB(5, 50, 0, 0),
                    child: Row( 
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                      
                      new SizedBox(
                        width: width,
                        height: height,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0)
                          ),
                          onPressed: (){},
                          child: Text('Total no:of $_currentValue students : $_total',
                            style: TextStyle (fontSize: 15.0),
                            textAlign: TextAlign.center
                          ),
                          padding: const EdgeInsets.all(25),
                          textColor: Colors.white,
                          color: Colors.cyan,   
                      ),),
                      new SizedBox(
                        width: width,
                        height: height,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0)
                          ),
                          onPressed: (){},
                          child: Text('Total no:of CSE $_currentValue students : $totalDept',
                          style: TextStyle (fontSize: 15.0),
                          ),
                        padding: const EdgeInsets.all(25),
                        textColor: Colors.black87,
                        color: Colors.amberAccent,   
                      ),),
                  ],),),
                  new Container(
                    margin:  EdgeInsets.fromLTRB(5, 50, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                      
                      new SizedBox(
                        width: width,
                        height: height,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0)
                          ),
                          onPressed: (){},
                          child: Text('No:of students placed : $_placed',
                          style: TextStyle (fontSize: 15.0)
                          ),
                        padding: const EdgeInsets.all(25),
                        textColor: Colors.white,
                        color: Colors.deepPurpleAccent,   
                      ),),
                      new SizedBox(
                        width: width,
                        height: height,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0)
                          ),
                          onPressed: (){},
                          child: Text('No:of students not placed : $_notPlaced',
                          style: TextStyle (fontSize: 15.0),
                          ),
                        padding: const EdgeInsets.all(25),
                        textColor: Colors.white,
                        color: Colors.deepOrangeAccent,   
                      ),),
                  ],),),
              ],
            ),
          ),
          );
          }   


           Future<Null> call (DatabaseReference databaseReference) async{
            DataSnapshot dataSnapshot = await databaseReference.once();
            String sheetName = dept + "-" + _currentValue.toString();
            Map<dynamic,dynamic> b = dataSnapshot.value;
            if (b[sheetName] == null) {
              totalDept = 0;
              _placed = 0;
              _notPlaced = 0;
            } else {
              List<dynamic>a = b[sheetName];
              totalDept = a.length-1;
              _placed = 0;
              for (int i = 1; i < a.length; i++) {
                if (a[i]['Company'] != "" && a[i]["Company"] != null) {
                  _placed++;
                }
              }
              _notPlaced = totalDept - _placed;
            }
          }
      
}