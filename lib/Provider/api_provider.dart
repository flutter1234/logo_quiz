import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api extends ChangeNotifier {
  Map mainData = {};
  String wordJson = "";
  Map wordList = {};

  Future<void> getData() async {
    var url = Uri.parse("https://coinspinmaster.com/viral/iosapp/jenis/logo_quiz/main.json");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      mainData = jsonDecode(response.body);
      notifyListeners();
    }
    notifyListeners();
    // print('mainData ==========>>>>>>${mainData}');
  }

  Future<void> logoQuiz() async {
    wordJson = mainData['assets']['wordJson'];
    var url = Uri.parse(wordJson);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      wordList = jsonDecode(response.body);
      notifyListeners();
    }
    notifyListeners();
    print('wordList ==========>>>>>>${wordList}');
  }
}
