import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logo_quiz/Provider/api_provider.dart';
import 'package:logo_quiz/Screen/level_screen/level_screen.dart';
import 'package:logo_quiz/Screen/spin_master_screen/spin_screen.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class home_screen extends StatefulWidget {
  static const routeName = '/home_screen';

  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Api dataProvider = Provider.of<Api>(context, listen: true);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: dataProvider.backGround,
          body: Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 30.sp,
                          width: 30.w,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.w, color: Colors.white),
                            color: dataProvider.levelContainer2,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Icon(
                            Icons.settings,
                            size: 22.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 30.sp,
                            width: 100.w,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.w, color: Colors.white),
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Center(
                              child: Text(
                                "${dataProvider.star}",
                                style: GoogleFonts.lexend(
                                  fontSize: 20.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: -14.w,
                            child: Image(
                              height: 30.sp,
                              image: AssetImage(
                                'assets/images/star.png',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 30.sp,
                            width: 100.w,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.w, color: Colors.white),
                              // border: Border.all(width: 2.w, color: HexColor('0096C7')),
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.sp),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Spacer(),
                                  Text(
                                    "${dataProvider.coin}",
                                    style: GoogleFonts.lexend(
                                      fontSize: 20.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 20.sp,
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                      color: Colors.green,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        size: 18.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: -14.w,
                            child: Image(
                              height: 30.sp,
                              image: AssetImage(
                                'assets/images/coin.png',
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
                Padding(
                  padding: EdgeInsets.only(left: 10.w, top: 10.h),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "LOGO GAME",
                      style: GoogleFonts.lexend(
                        fontSize: 30.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Quiz your brands knowledge",
                      style: GoogleFonts.lexend(
                        fontSize: 20.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 3,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, levels_screen.routeName).then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    height: 60.sp,
                    width: 200.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.r),
                      border: Border.all(width: 3.w, color: Colors.white),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/play_button.png"),
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Text(
                          "Play",
                          style: GoogleFonts.lexend(
                            fontSize: 30.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        dataProvider.themeChangeDialog = true;
                        setState(() {});
                      },
                      child: Container(
                        height: 50.sp,
                        width: 50.w,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.w, color: Colors.white),
                          shape: BoxShape.circle,
                          color: Colors.blueAccent.shade400,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(6.sp),
                          child: Image.asset("assets/images/themes.png"),
                        ),
                      ),
                    ),
                    SizedBox(width: 25.w),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, spin_screen.routeName).then((value) {
                          setState(() {});
                        });
                      },
                      child: Container(
                        height: 50.sp,
                        width: 50.w,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.w, color: Colors.white),
                          shape: BoxShape.circle,
                          color: Colors.blueAccent.shade400,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5.sp),
                          child: Image.asset("assets/images/dollar.png"),
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ),
        dataProvider.themeChangeDialog == true
            ? Scaffold(
                backgroundColor: Colors.transparent,
                body: Container(
                  height: 1.sh,
                  width: 1.sw,
                  color: Colors.black45,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.sp),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 2.w, color: Colors.white),
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.center,
                              colors: [
                                Colors.black54,
                                Colors.black54,
                                // HexColor('1477d2'),
                                // HexColor('023E8A'),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: isIpad ? 30.sp : 40.sp,
                                width: 1.sw,
                                decoration: BoxDecoration(
                                  color: HexColor('023E8A'),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.r),
                                    topRight: Radius.circular(10.r),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(width: 25.w),
                                      Text(
                                        "THEME",
                                        style: GoogleFonts.notoSans(
                                          fontSize: isIpad ? 18.sp : 22.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            dataProvider.themeChangeDialog = false;
                                          });
                                        },
                                        child: Icon(
                                          Icons.close,
                                          size: isIpad ? 25.sp : 28.sp,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: isIpad ? 8.sp : 10.sp),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        dataProvider.backGround = HexColor('023E8A');
                                        storage.write("backGround", dataProvider.backGround.value.toRadixString(16));
                                        dataProvider.levelContainer1 = HexColor('3271a5');
                                        storage.write("levelContainer1", dataProvider.levelContainer1.value.toRadixString(16));
                                        dataProvider.levelContainer2 = HexColor('1477d2');
                                        storage.write("levelContainer2", dataProvider.levelContainer2.value.toRadixString(16));
                                        dataProvider.themeChangeDialog = false;
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: isIpad ? 150.sp : 150.sp,
                                        width: 140.w,
                                        decoration: BoxDecoration(
                                          color: HexColor('023E8A'),
                                          border: Border.all(width: 1.w, color: Colors.white),
                                          borderRadius: BorderRadius.circular(10.r),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        dataProvider.backGround = HexColor('79305a');
                                        storage.write("backGround", dataProvider.backGround.value.toRadixString(16));
                                        dataProvider.themeChangeDialog = false;
                                        dataProvider.levelContainer1 = HexColor('8e3563');
                                        storage.write("levelContainer1", dataProvider.levelContainer1.value.toRadixString(16));
                                        dataProvider.levelContainer2 = HexColor('b33b72');
                                        storage.write("levelContainer2", dataProvider.levelContainer2.value.toRadixString(16));
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: isIpad ? 150.sp : 150.sp,
                                        width: 140.w,
                                        decoration: BoxDecoration(
                                          color: HexColor('79305a'),
                                          borderRadius: BorderRadius.circular(10.r),
                                          border: Border.all(width: 1.w, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: isIpad ? 8.sp : 10.sp),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        dataProvider.backGround = HexColor('2d3b43');
                                        storage.write("backGround", dataProvider.backGround.value.toRadixString(16));
                                        dataProvider.levelContainer1 = HexColor('3e515b');
                                        storage.write("levelContainer1", dataProvider.levelContainer1.value.toRadixString(16));
                                        dataProvider.levelContainer2 = HexColor('4d6471');
                                        storage.write("levelContainer2", dataProvider.levelContainer2.value.toRadixString(16));
                                        dataProvider.themeChangeDialog = false;
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: isIpad ? 150.sp : 150.sp,
                                        width: 140.w,
                                        decoration: BoxDecoration(
                                          color: HexColor('2d3b43'),
                                          border: Border.all(width: 1.w, color: Colors.white),
                                          borderRadius: BorderRadius.circular(10.r),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        dataProvider.backGround = HexColor('df2c14');
                                        storage.write("backGround", dataProvider.backGround.value.toRadixString(16));
                                        dataProvider.levelContainer1 = HexColor('ed3419');
                                        storage.write("levelContainer1", dataProvider.levelContainer1.value.toRadixString(16));
                                        dataProvider.levelContainer2 = HexColor('fb3b1e');
                                        storage.write("levelContainer2", dataProvider.levelContainer2.value.toRadixString(16));
                                        dataProvider.themeChangeDialog = false;
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: isIpad ? 150.sp : 150.sp,
                                        width: 140.w,
                                        decoration: BoxDecoration(
                                          color: HexColor('df2c14'),
                                          borderRadius: BorderRadius.circular(10.r),
                                          border: Border.all(width: 1.w, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : SizedBox(),
      ],
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
