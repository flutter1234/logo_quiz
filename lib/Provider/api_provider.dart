// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class Api extends ChangeNotifier {
  String wordJson = "";
  Map wordList = {};
  String spinJson = "";
  Map spinList = {};
  ScreenshotController screenshotController = ScreenshotController();
  List mainLevel = [];
  List subLevel = [];
  bool themeChangeDialog = false;
  Color backGround = HexColor('023E8A');
  Color levelContainer1 = HexColor('3271a5');
  Color levelContainer2 = HexColor('46a2da');
  int coin = 0;
  int star = 0;

  Future<void> logoQuiz(var Url) async {
    var url = Uri.parse(Url);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      wordList = jsonDecode(response.body);
      notifyListeners();
    }
    notifyListeners();
    // print('wordList ==========>>>>>>${wordList}');
  }

  Future<void> spinData(var Url) async {
    var url = Uri.parse(Url);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      spinList = jsonDecode(response.body);
      notifyListeners();
    }
    notifyListeners();
    print('spinList ==========>>>>>>${spinList}');
  }

  Future<void> shareImage() async {
    await screenshotController.capture(delay: const Duration(milliseconds: 10)).then(
      (Uint8List? image) async {
        if (image != null) {
          final directory = await getApplicationDocumentsDirectory();
          final imagePath = await File('${directory.path}/image.png').create();
          await imagePath.writeAsBytes(image);
          await Share.shareFiles([imagePath.path]);
        }
      },
    );
  }
}
