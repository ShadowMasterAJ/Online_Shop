import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _tokenExpiryDate;
  String _userID;

  bool get isAuth {
    return _token != null;
  }

  String get token {
    if (_tokenExpiryDate != null &&
        _tokenExpiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userID {
    return _userID;
  }

  Future<void> _authenticate(String email, password, urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAgq-Ls6VKGfAO4UiO6w85tZCYQWVDFHrw');
    try {
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
      final responseBody = json.decode(response.body);
      if (responseBody['error'] != null) {
        throw HttpException(responseBody['error']['message']);
      }
      _token = responseBody['idToken'];
      _userID = responseBody['localId'];
      _tokenExpiryDate = DateTime.now().add(
        Duration(seconds: int.parse(responseBody['expiresIn'])),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> userSignUp(String email, password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> userLogin(String email, password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
