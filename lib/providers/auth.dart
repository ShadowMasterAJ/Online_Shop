import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Auth extends ChangeNotifier {
  String _token;
  DateTime _tokenExpiryDate;
  String userID;

  Future<void> userSignUp(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAgq-Ls6VKGfAO4UiO6w85tZCYQWVDFHrw');
    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    print(jsonDecode(response.body));
  }
}
