import 'package:alumni_tracking_system/pages/forgotPassword.dart';
import 'package:alumni_tracking_system/services/authentication.dart';
import 'package:flutter/material.dart';

class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;

    bool _isLoginForm;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      String userId = "";
      try {
        if (_isLoginForm) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else {
          userId = await widget.auth.signUp(_email, _password);
          //widget.auth.sendEmailVerification();
          //_showVerifyEmailSentDialog();
          print('Signed up user: $userId');
        }
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null && _isLoginForm) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Stack(
          children: <Widget>[
            _showForm(),
            _showCircularProgress(),
          ],
        ));
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }


  Widget _showForm() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              showLogo(),
              showEmailInput(),
              showPasswordInput(),
              showForgotPassword(),
              showPrimaryButton(),
              
                            // showSecondaryButton(),
                            showErrorMessage(),
                          ],
                        ),
                      ));
                }
                
              
                Widget showLogo() {
                  var height = MediaQuery.of(context).size.height;
                  return new Container (
                          margin: EdgeInsets.only(top : 75.0, bottom : 0.0),
                          child: Column (
                          children: <Widget>[
                            new Image(
                          image: new AssetImage("assets/bvrithlogo.png"),
                          fit: BoxFit.cover,
                          height: height/5,
                        ),
                            ]
                          )
                        );
                        
                }
              
                Widget showEmailInput() {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
                    child: new TextFormField(
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      decoration: new InputDecoration(
                          hintText: 'Email',
                          icon: new Icon(
                            Icons.mail,
                            color: Colors.grey,
                          )),
                      validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                      onSaved: (value) => _email = value.trim(),
                    ),
                  );
                }
              
                Widget showPasswordInput() {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                    child: new TextFormField(
                      maxLines: 1,
                      obscureText: true,
                      autofocus: false,
                      decoration: new InputDecoration(
                          hintText: 'Password',
                          icon: new Icon(
                            Icons.lock,
                            color: Colors.grey,
                          )),
                      validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
                      onSaved: (value) => _password = value.trim(),
                    ),
                  );
                }
              
                Widget showSecondaryButton() {
                  return new FlatButton(
                      child: new Text(
                          _isLoginForm ? 'Create an account' : 'Have an account? Sign in',
                          style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
                      onPressed: toggleFormMode);
                }
              
                Widget showPrimaryButton() {
                  return new Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 10.0),
                      child: SizedBox(
                        height: 40.0,
                        child: new RaisedButton(
                          elevation: 5.0,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          color: Colors.green,
                          child: new Text(_isLoginForm ? 'Login' : 'Create account',
                              style: new TextStyle(fontSize: 20.0, color: Colors.white)),
                          onPressed: validateAndSubmit,
                        ),
                      ));
                }
                Widget showForgotPassword() {
                return new  Container(
                      alignment: Alignment(1.0, 0.0),
                      //padding: EdgeInsets.only(top : 20.0,left: 20.0, right: 20.0),
                      child: FlatButton(
                        onPressed: () { 
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                         },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    );
              }
                Widget showErrorMessage() {
                  if (_errorMessage.length > 0 && _errorMessage != null) {
                    return new Text(
                      _errorMessage,
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.red,
                          height: 1.0,
                          fontWeight: FontWeight.w300),
                    );
                  } else {
                    return new Container(
                      height: 0.0,
                    );
                  }
                }
              }
              
