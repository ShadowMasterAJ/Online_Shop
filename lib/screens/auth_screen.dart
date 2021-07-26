import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/http_exception.dart';

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

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  AnimationController _animationController;
  Animation<Offset> _slideAnimation;
  Animation<double> _opacityTranstition;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
      reverseDuration: Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -.2),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linearToEaseOut,
    ));

    _opacityTranstition = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linearToEaseOut,
    ));
  }

  void _showErrorDialog(String errorMessage, BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              elevation: 10,
              backgroundColor: Colors.grey[900],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Text('An error ocurred!',
                  style: TextStyle(color: Theme.of(context).errorColor)),
              content: Text(errorMessage,
                  style: TextStyle(color: Theme.of(context).accentColor)),
              actions: [
                TextButton(
                  child: Text(
                    'Okay',
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ));
  }

  // void dispose() {
  //   super.dispose();
  //   _animationController.dispose();
  // }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    if (!mounted) return;

    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false).userLogin(
          _authData['email'],
          _authData['password'],
        );
      }
      // Sign user up
      else {
        await Provider.of<Auth>(context, listen: false).userSignUp(
          _authData['email'],
          _authData['password'],
        );
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'The email address is already in use!';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'The email address is invalid!';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'The password is too weak!';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'The email address could not be found';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'The password is invalid!';
      }
      _showErrorDialog(errorMessage, context);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you\nPlease try again later!';
      _showErrorDialog(errorMessage, context);
    }
    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _animationController.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _animationController.reverse();
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
      child: AnimatedContainer(
        duration: Duration(milliseconds: 700),
        curve: Curves.linearToEaseOut,
        height: _authMode == AuthMode.Signup ? 270 : 240,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 295 : 240),
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
                AnimatedContainer(
                  duration: Duration(milliseconds: 700),
                  curve: Curves.linearToEaseOut,
                  constraints: BoxConstraints(
                      minHeight: _authMode == AuthMode.Signup ? 40 : 0,
                      maxHeight: _authMode == AuthMode.Signup ? 80 : 0),
                  child: FadeTransition(
                    opacity: _opacityTranstition,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: TextFormField(
                        enabled: _authMode == AuthMode.Signup,
                        decoration:
                            InputDecoration(labelText: 'Confirm Password'),
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
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                              horizontal: 25.0, vertical: 10.0),
                          primary: Theme.of(context).primaryColorDark,
                        ),
                      ),
                      TextButton(
                          child: Text(
                            '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'}\n INSTEAD',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              // color: Theme.of(context).accentColor,
                              fontSize: 20,
                            ),
                          ),
                          onPressed: _switchAuthMode,
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 4),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            textStyle: TextStyle(
                                color: Theme.of(context).primaryColorDark),
                          )),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
