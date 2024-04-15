import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logo_quiz/Provider/api_provider.dart';
import 'package:logo_quiz/Screen/Home_screen/home_screen.dart';
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
  void initState() {
    Api dataProvider = Provider.of<Api>(context, listen: false);

    dataProvider.backGround = storage.read("backGround") ?? dataProvider.backGround;
    print("background ====>>${dataProvider.backGround}");
    context.read<Api>().getData().then((value) {
      context.read<Api>().logoQuiz().then((value) {
        Navigator.pushReplacementNamed(context, home_screen.routeName);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
}
