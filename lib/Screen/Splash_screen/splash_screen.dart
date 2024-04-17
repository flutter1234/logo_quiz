import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logo_quiz/Provider/api_provider.dart';
import 'package:logo_quiz/main.dart';
import 'package:provider/provider.dart';

class splash_screen extends StatefulWidget {
  static const routeName = '/splash_screen';

  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  Widget build(BuildContext context) {
    fetchData();
    Api dataProvider = Provider.of<Api>(context, listen: true);
    return Scaffold(
      backgroundColor: dataProvider.backGround,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Splash Screen",
              style: GoogleFonts.notoSans(
                fontSize: 22.sp,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchData() async {
    Api dataProvider = Provider.of<Api>(context, listen: false);
    dataProvider.coin = storage.read("coin") ?? 0;
    dataProvider.star = storage.read("star") ?? 0;

    String? storedBackGround = storage.read("backGround");
    String? storedLevelContainer1 = storage.read("levelContainer1");
    String? storedLevelContainer2 = storage.read("levelContainer2");
    if (storedBackGround != null && storedLevelContainer1 != null && storedLevelContainer2 != null) {
      dataProvider.backGround = Color(int.parse(storedBackGround, radix: 16));
      dataProvider.levelContainer1 = Color(int.parse(storedLevelContainer1, radix: 16));
      dataProvider.levelContainer2 = Color(int.parse(storedLevelContainer2, radix: 16));
    } else {
      dataProvider.backGround = HexColor('023E8A');
      dataProvider.levelContainer1 = HexColor('3271a5');
      dataProvider.levelContainer2 = HexColor('46a2da');
    }
  }
}
