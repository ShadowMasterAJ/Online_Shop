import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.orange,
          Colors.deepOrange,
          Colors.deepOrange,
          Colors.orange,
        ],
      )),
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.transparent),
            ),
            SingleChildScrollView(
              child: Container(
                height: deviceSize.height,
                width: deviceSize.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20.0),
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 90.0),
                        transform: Matrix4.rotationZ(-5 * pi / 180)
                          ..translate(-10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[900],
                          boxShadow: [
                            BoxShadow(
                              // blurRadius: 0,
                              color: Colors.black,
                              offset: Offset(0, 10),
                            )
                          ],
                        ),
                        child: Text(
                          'ShopStop',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 50,
                            fontFamily: 'Anton',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: deviceSize.width > 600 ? 2 : 1,
                      child: AuthCard(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _submit() {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_authMode == AuthMode.Login) {
      // Log user in
    } else {
      // Sign user up
      Provider.of<Auth>(context, listen: false)
          .userSignUp(_authData['email'], _authData['password']);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 330 : 270,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty ||
                        !value.contains('@') ||
                        !value.contains('e.ntu.edu.sg')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                            return null;
                          }
                        : null,
                  ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    child: Text(
                      _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      primary: Theme.of(context).primaryColorDark,
                    ),
                  ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD',
                      style: TextStyle(
                        // color: Theme.of(context).accentColor,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: _switchAuthMode,
                    style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
