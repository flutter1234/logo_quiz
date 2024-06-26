import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logo_quiz/AdPlugin/Ads/Banner/BannerWrapper.dart';
import 'package:logo_quiz/AdPlugin/Ads/FullScreen/Ads.dart';
import 'package:logo_quiz/AdPlugin/Ads/Native/NativeRN.dart';
import 'package:logo_quiz/AdPlugin/MainJson/MainJson.dart';
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
  bool isLoading = true;
  bool settingDialog = false;
  int logoLength = 0;
  int solvedQuestion = 0;

  @override
  void initState() {
    Api dataProvider = Provider.of<Api>(context, listen: false);
    dataProvider.soundOn = storage.read("soundOn") ?? true;
    dataProvider.musicOn = storage.read("musicOn") ?? true;
    dataProvider.totalHint = storage.read("totalHint") ?? 0;
    dataProvider.levelLength = storage.read("levelLength") ?? 0;
    dataProvider.failedAttempts = storage.read("failedAttempts") ?? 0;
    context.read<Api>().logoQuiz(context.read<MainJson>().data!['assets']['wordJson']).then((value) {
      lengthData();
      isLoading = false;
    });

    if (dataProvider.musicOn == true) {
      dataProvider.initAudioPlayer();
    }
    super.initState();
  }

  lengthData() {
    Api dataProvider = Provider.of<Api>(context, listen: false);
    logoLength = 0;
    solvedQuestion = 0;
    for (int i = 0; i < dataProvider.wordList['word'].length; i++) {
      logoLength = logoLength + int.parse(dataProvider.wordList['word'][i]['Level ${i + 1}'].length.toString());
      List completeLogo = storage.read("LEVEL ${i + 1}") ?? [];
      solvedQuestion = solvedQuestion + completeLogo.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    Api dataProvider = Provider.of<Api>(context, listen: true);
    return Stack(
      children: [
        BannerWrapper(
          parentContext: context,
          child: Scaffold(
            backgroundColor: dataProvider.backGround,
            body: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(
                      top: isSmall
                          ? 45.h
                          : isIpad
                              ? 30.h
                              : 50.h,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (dataProvider.soundOn == true) {
                                    dataProvider.initOnTap();
                                  }
                                  settingDialog = true;
                                  lengthData();
                                  setState(() {});
                                },
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
                                    left: -12.w,
                                    top: -3.h,
                                    child: Image(
                                      height: 35.sp,
                                      image: AssetImage(
                                        'assets/images/spin.png',
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.w, top: isSmall ? 10.h : 20.h),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "LOGO GAME",
                              style: GoogleFonts.lexend(
                                fontSize: isIpad
                                    ? 20.sp
                                    : isSmall
                                        ? 22.sp
                                        : 30.sp,
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
                                fontSize: isIpad
                                    ? 16.sp
                                    : isSmall
                                        ? 18.sp
                                        : 20.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        Spacer(flex: 1),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (dataProvider.soundOn == true) {
                                  dataProvider.initOnTap();
                                }
                                dataProvider.themeChangeDialog = true;
                                setState(() {});
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10.w, top: isSmall ? 5.h : 10.h),
                                  child: Container(
                                    height: isIpad
                                        ? 35.sp
                                        : isSmall
                                            ? 40.sp
                                            : 45.sp,
                                    width: isIpad
                                        ? 35.w
                                        : isSmall
                                            ? 40.w
                                            : 45.w,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1.w, color: Colors.white),
                                      shape: BoxShape.circle,
                                      color: Colors.blueAccent.shade400,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(5.sp),
                                      child: Image.asset("assets/images/themes.png"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            dataProvider.themeChangeDialog == true
                                ? Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 25.sp),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: isSmall ? 10.h : 12.h, right: 12.w),
                                          decoration: BoxDecoration(
                                            color: Colors.black45,
                                            border: Border.all(width: 1.w, color: Colors.white),
                                            borderRadius: BorderRadius.circular(10.r),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: isSmall ? 2.sp : 5.sp),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    dataProvider.backGround = HexColor('023E8A');
                                                    storage.write("backGround", dataProvider.backGround.value.toRadixString(16));
                                                    dataProvider.levelContainer1 = HexColor('3271a5');
                                                    storage.write("levelContainer1", dataProvider.levelContainer1.value.toRadixString(16));
                                                    dataProvider.levelContainer2 = HexColor('1477d2');
                                                    storage.write("levelContainer2", dataProvider.levelContainer2.value.toRadixString(16));
                                                    if (dataProvider.soundOn == true) {
                                                      dataProvider.initOnTap();
                                                    }
                                                    dataProvider.themeChangeDialog = false;
                                                    setState(() {});
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.all(isIpad ? 3.sp : 5.sp),
                                                    child: Container(
                                                      height: isSmall
                                                          ? 40.sp
                                                          : isIpad
                                                              ? 38.sp
                                                              : 45.sp,
                                                      width: isSmall
                                                          ? 40.w
                                                          : isIpad
                                                              ? 38.sp
                                                              : 45.w,
                                                      decoration: BoxDecoration(
                                                        color: HexColor('023E8A'),
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          width: 1.w,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    dataProvider.backGround = HexColor('79305a');
                                                    storage.write("backGround", dataProvider.backGround.value.toRadixString(16));
                                                    dataProvider.levelContainer1 = HexColor('8e3563');
                                                    storage.write("levelContainer1", dataProvider.levelContainer1.value.toRadixString(16));
                                                    dataProvider.levelContainer2 = HexColor('b33b72');
                                                    storage.write("levelContainer2", dataProvider.levelContainer2.value.toRadixString(16));
                                                    if (dataProvider.soundOn == true) {
                                                      dataProvider.initOnTap();
                                                    }
                                                    dataProvider.themeChangeDialog = false;

                                                    setState(() {});
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.all(isIpad ? 3.sp : 5.sp),
                                                    child: Container(
                                                      height: isSmall
                                                          ? 40.sp
                                                          : isIpad
                                                              ? 38.sp
                                                              : 45.sp,
                                                      width: isSmall
                                                          ? 40.w
                                                          : isIpad
                                                              ? 38.sp
                                                              : 45.w,
                                                      decoration: BoxDecoration(
                                                        color: HexColor('79305a'),
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          width: 1.w,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    dataProvider.backGround = HexColor('2d3b43');
                                                    storage.write("backGround", dataProvider.backGround.value.toRadixString(16));
                                                    dataProvider.levelContainer1 = HexColor('3e515b');
                                                    storage.write("levelContainer1", dataProvider.levelContainer1.value.toRadixString(16));
                                                    dataProvider.levelContainer2 = HexColor('4d6471');
                                                    storage.write("levelContainer2", dataProvider.levelContainer2.value.toRadixString(16));
                                                    if (dataProvider.soundOn == true) {
                                                      dataProvider.initOnTap();
                                                    }
                                                    dataProvider.themeChangeDialog = false;

                                                    setState(() {});
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.all(isIpad ? 3.sp : 5.sp),
                                                    child: Container(
                                                      height: isSmall
                                                          ? 40.sp
                                                          : isIpad
                                                              ? 38.sp
                                                              : 45.sp,
                                                      width: isSmall
                                                          ? 40.w
                                                          : isIpad
                                                              ? 38.sp
                                                              : 45.w,
                                                      decoration: BoxDecoration(
                                                        color: HexColor('2d3b43'),
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          width: 1.w,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    dataProvider.backGround = HexColor('d24e01');
                                                    storage.write("backGround", dataProvider.backGround.value.toRadixString(16));
                                                    dataProvider.levelContainer1 = HexColor('dc6601');
                                                    storage.write("levelContainer1", dataProvider.levelContainer1.value.toRadixString(16));
                                                    dataProvider.levelContainer2 = HexColor('e88504');
                                                    storage.write("levelContainer2", dataProvider.levelContainer2.value.toRadixString(16));
                                                    if (dataProvider.soundOn == true) {
                                                      dataProvider.initOnTap();
                                                    }
                                                    dataProvider.themeChangeDialog = false;
                                                    setState(() {});
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.all(isIpad ? 3.sp : 5.sp),
                                                    child: Container(
                                                      height: isSmall
                                                          ? 40.sp
                                                          : isIpad
                                                              ? 38.sp
                                                              : 45.sp,
                                                      width: isSmall
                                                          ? 40.w
                                                          : isIpad
                                                              ? 38.sp
                                                              : 45.w,
                                                      decoration: BoxDecoration(
                                                        color: HexColor('d24e01'),
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          width: 1.w,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        dataProvider.themeChangeDialog == true
                                            ? Positioned(
                                                right: 0.w,
                                                top: 0.h,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (dataProvider.soundOn == true) {
                                                        dataProvider.initOnTap();
                                                      }
                                                      dataProvider.themeChangeDialog = false;
                                                    });
                                                  },
                                                  child: Container(
                                                    height: isSmall
                                                        ? 25.sp
                                                        : isIpad
                                                            ? 25.sp
                                                            : 30.sp,
                                                    width: isSmall
                                                        ? 25.sp
                                                        : isIpad
                                                            ? 25.w
                                                            : 30.w,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(6.r),
                                                        color: dataProvider.levelContainer2,
                                                        border: Border.all(width: 1.w, color: Colors.white)),
                                                    child: Icon(
                                                      Icons.close,
                                                      size: 20.sp,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                            Spacer(),
                          ],
                        ),
                        NativeRN(parentContext: context),
                        Spacer(flex: 2),
                        GestureDetector(
                          onTap: () {
                            if (dataProvider.soundOn == true) {
                              dataProvider.initOnTap();
                            }
                            AdsRN().showFullScreen(
                              context: context,
                              onComplete: () {
                                Navigator.pushNamed(context, spin_screen.routeName).then((value) {
                                  setState(() {});
                                });
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(isSmall ? 3.sp : 5.sp),
                            child: Container(
                              height: isIpad
                                  ? 50.sp
                                  : isSmall
                                      ? 45.sp
                                      : 60.sp,
                              width: isIpad
                                  ? 180.w
                                  : isSmall
                                      ? 180.w
                                      : 200.w,
                              decoration: BoxDecoration(
                                color: dataProvider.levelContainer2,
                                borderRadius: BorderRadius.circular(isIpad ? 12.r : 14.r),
                                border: Border.all(width: 2.w, color: Colors.white),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage('assets/images/spin.png'),
                                    height: isSmall ? 30.sp : 35.sp,
                                    fit: BoxFit.fill,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.w),
                                    child: Text(
                                      "Reward",
                                      style: GoogleFonts.lexend(
                                        fontSize: isIpad
                                            ? 25.sp
                                            : isSmall
                                                ? 22.sp
                                                : 28.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (dataProvider.soundOn == true) {
                              dataProvider.initOnTap();
                            }
                            AdsRN().showFullScreen(
                              context: context,
                              onComplete: () {
                                Navigator.pushNamed(context, levels_screen.routeName).then((value) {
                                  setState(() {});
                                });
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(isSmall ? 3.sp : 5.sp),
                            child: Container(
                              height: isIpad
                                  ? 50.sp
                                  : isSmall
                                      ? 45.sp
                                      : 60.sp,
                              width: isIpad
                                  ? 180.w
                                  : isSmall
                                      ? 180.w
                                      : 200.w,
                              decoration: BoxDecoration(
                                color: dataProvider.levelContainer2,
                                borderRadius: BorderRadius.circular(isIpad ? 12.r : 14.r),
                                border: Border.all(width: 2.w, color: Colors.white),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage('assets/images/play.png'),
                                    height: isSmall ? 30.sp : 30.sp,
                                    fit: BoxFit.fill,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: isSmall ? 10.w : 15.w, right: isSmall ? 30.w : 20.w),
                                    child: Text(
                                      "Play",
                                      style: GoogleFonts.lexend(
                                        fontSize: isIpad
                                            ? 25.sp
                                            : isSmall
                                                ? 22.sp
                                                : 30.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Spacer(flex: 1),
                        SizedBox(width: 25.w),
                        Spacer(),
                      ],
                    ),
                  ),
          ),
        ),
        settingDialog == true
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
                        padding: EdgeInsets.symmetric(horizontal: 35.sp),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 2.w, color: Colors.white),
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.center,
                              colors: [
                                dataProvider.levelContainer1,
                                dataProvider.levelContainer2,
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
                                  color: dataProvider.backGround,
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
                                        "SETTINGS",
                                        style: GoogleFonts.lexend(
                                          fontSize: isIpad ? 18.sp : 22.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (dataProvider.soundOn == true) {
                                              dataProvider.initOnTap();
                                            }
                                            settingDialog = false;
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
                                padding: EdgeInsets.symmetric(horizontal: 25.sp, vertical: 10.sp),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (dataProvider.soundOn == true) {
                                          dataProvider.initOnTap();
                                        }
                                        dataProvider.musicOn = !dataProvider.musicOn;
                                        storage.write("musicOn", dataProvider.musicOn);
                                        if (dataProvider.musicOn == true) {
                                          dataProvider.audioPlayerBackground.play();
                                        } else {
                                          dataProvider.audioPlayerBackground.pause();
                                        }
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 40.sp,
                                        width: 40.w,
                                        decoration: BoxDecoration(
                                          color: dataProvider.levelContainer1,
                                          border: Border.all(width: 1.w, color: Colors.white),
                                          borderRadius: BorderRadius.circular(6.r),
                                        ),
                                        child: Icon(
                                          dataProvider.musicOn == true ? Icons.music_note_sharp : Icons.music_off_rounded,
                                          color: Colors.white,
                                          size: 28.sp,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        dataProvider.soundOn = !dataProvider.soundOn;
                                        storage.write("soundOn", dataProvider.soundOn);
                                        if (dataProvider.soundOn == true) {
                                          dataProvider.initOnTap();
                                        }
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 40.sp,
                                        width: 40.w,
                                        decoration: BoxDecoration(
                                          color: dataProvider.levelContainer1,
                                          border: Border.all(width: 1.w, color: Colors.white),
                                          borderRadius: BorderRadius.circular(6.r),
                                        ),
                                        child: Icon(
                                          dataProvider.soundOn == true ? Icons.volume_up_rounded : Icons.volume_off_outlined,
                                          color: Colors.white,
                                          size: 28.sp,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (dataProvider.soundOn == true) {
                                            dataProvider.initOnTap();
                                          }
                                          exit(0);
                                        });
                                      },
                                      child: Container(
                                        height: 40.sp,
                                        width: 40.w,
                                        decoration: BoxDecoration(
                                          color: dataProvider.levelContainer1,
                                          border: Border.all(width: 1.w, color: Colors.white),
                                          borderRadius: BorderRadius.circular(6.r),
                                        ),
                                        child: Icon(
                                          Icons.exit_to_app,
                                          color: Colors.white,
                                          size: 28.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40.sp, vertical: 5.sp),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (dataProvider.soundOn == true) {
                                        dataProvider.initOnTap();
                                      }
                                      settingDialog = false;
                                      dataProvider.statisticsDialog = true;
                                    });
                                  },
                                  child: Container(
                                    height: 35.sp,
                                    width: 1.sw,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1.w, color: Colors.white),
                                      borderRadius: BorderRadius.circular(6.r),
                                      color: dataProvider.levelContainer1,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "STATISTICS",
                                        style: GoogleFonts.lexend(
                                          fontSize: isIpad ? 18.sp : 20.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40.sp, vertical: 5.sp),
                                child: GestureDetector(
                                  onTap: () {
                                    if (dataProvider.soundOn == true) {
                                      dataProvider.initOnTap();
                                    }
                                    dataProvider.url = context.read<MainJson>().data!['assets']['contactUs'];
                                    setState(() {});
                                    dataProvider.launchurl();
                                  },
                                  child: Container(
                                    height: 35.sp,
                                    width: 1.sw,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1.w, color: Colors.white),
                                      borderRadius: BorderRadius.circular(6.r),
                                      color: dataProvider.levelContainer1,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "CONTACT US",
                                        style: GoogleFonts.lexend(
                                          fontSize: isIpad ? 18.sp : 20.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40.sp, vertical: 5.sp),
                                child: GestureDetector(
                                  onTap: () {
                                    if (dataProvider.soundOn == true) {
                                      dataProvider.initOnTap();
                                    }
                                    dataProvider.url = context.read<MainJson>().data!['assets']['shareApp'];
                                    setState(() {});
                                    dataProvider.launchurl();
                                  },
                                  child: Container(
                                    height: 35.sp,
                                    width: 1.sw,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1.w, color: Colors.white),
                                      borderRadius: BorderRadius.circular(6.r),
                                      color: dataProvider.levelContainer1,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "SHARE APP",
                                        style: GoogleFonts.lexend(
                                          fontSize: isIpad ? 18.sp : 20.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        dataProvider.url = context.read<MainJson>().data!['assets']['privacyPolicy'];
                                        setState(() {});
                                        dataProvider.launchurl();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: 2.h),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.white60,
                                              width: 1.w,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          "PRIVACY POLICY",
                                          style: GoogleFonts.lexend(
                                            fontSize: isIpad ? 12.sp : 14.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        dataProvider.url = context.read<MainJson>().data!['assets']['privacyPolicy'];
                                        setState(() {});
                                        dataProvider.launchurl();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: 2.h),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.white60,
                                              width: 1.w,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          "TERMS OF USE",
                                          style: GoogleFonts.lexend(
                                            fontSize: isIpad ? 12.sp : 14.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.sp),
                                child: Text(
                                  "V${context.read<MainJson>().version}",
                                  style: GoogleFonts.lexend(
                                    fontSize: isIpad ? 18.sp : 15.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
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
        dataProvider.statisticsDialog == true
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
                                dataProvider.levelContainer1,
                                dataProvider.levelContainer2,
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
                                  color: dataProvider.backGround,
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
                                        "STATISTICS",
                                        style: GoogleFonts.lexend(
                                          fontSize: isIpad ? 18.sp : 22.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (dataProvider.soundOn == true) {
                                              dataProvider.initOnTap();
                                            }
                                            dataProvider.statisticsDialog = false;
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
                                padding: EdgeInsets.symmetric(horizontal: 25.sp, vertical: 10.sp),
                                child: Container(
                                  height: 75.sp,
                                  width: 1.sw,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.black54,
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 6.sp),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "TOTAL QUESTIONS",
                                              style: GoogleFonts.lexend(
                                                fontSize: isIpad
                                                    ? 12.sp
                                                    : isSmall
                                                        ? 14.sp
                                                        : 14.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                            Text(
                                              "${logoLength}",
                                              style: GoogleFonts.lexend(
                                                fontSize: isIpad
                                                    ? 12.sp
                                                    : isSmall
                                                        ? 14.sp
                                                        : 14.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1,
                                        height: 0.5.sp,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 1.sp),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "SOLVED",
                                              style: GoogleFonts.lexend(
                                                fontSize: isIpad
                                                    ? 12.sp
                                                    : isSmall
                                                        ? 12.sp
                                                        : 14.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              "${solvedQuestion}",
                                              style: GoogleFonts.lexend(
                                                fontSize: isIpad
                                                    ? 12.sp
                                                    : isSmall
                                                        ? 12.sp
                                                        : 14.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.sp),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "UNSOLVED",
                                              style: GoogleFonts.lexend(
                                                fontSize: isIpad
                                                    ? 12.sp
                                                    : isSmall
                                                        ? 12.sp
                                                        : 14.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              "${logoLength - solvedQuestion}",
                                              style: GoogleFonts.lexend(
                                                fontSize: isIpad
                                                    ? 12.sp
                                                    : isSmall
                                                        ? 12.sp
                                                        : 14.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.sp),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "GAME PROGRESS",
                                      style: GoogleFonts.lexend(
                                        fontSize: isIpad
                                            ? 14.sp
                                            : isSmall
                                                ? 16.sp
                                                : 18.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      "${((solvedQuestion / logoLength) * 100).toStringAsFixed(1)}%",
                                      style: GoogleFonts.lexend(
                                        fontSize: isIpad
                                            ? 14.sp
                                            : isSmall
                                                ? 16.sp
                                                : 18.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.sp, vertical: 10.sp),
                                child: Container(
                                  height: 52.sp,
                                  width: 1.sw,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.black54,
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "TOTAL HINTS USED",
                                              style: GoogleFonts.lexend(
                                                fontSize: isIpad
                                                    ? 12.sp
                                                    : isSmall
                                                        ? 12.sp
                                                        : 14.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              "${dataProvider.totalHint}",
                                              style: GoogleFonts.lexend(
                                                fontSize: isIpad
                                                    ? 12.sp
                                                    : isSmall
                                                        ? 12.sp
                                                        : 14.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.sp),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "FAILED ATTEMPTS",
                                              style: GoogleFonts.lexend(
                                                fontSize: isIpad
                                                    ? 12.sp
                                                    : isSmall
                                                        ? 12.sp
                                                        : 14.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              "${dataProvider.failedAttempts}",
                                              style: GoogleFonts.lexend(
                                                fontSize: isIpad
                                                    ? 12.sp
                                                    : isSmall
                                                        ? 12.sp
                                                        : 14.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.sp),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "LEVELS COMPLETED",
                                      style: GoogleFonts.lexend(
                                        fontSize: isIpad
                                            ? 14.sp
                                            : isSmall
                                                ? 16.sp
                                                : 18.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      "${dataProvider.levelLength}",
                                      style: GoogleFonts.lexend(
                                        fontSize: isIpad
                                            ? 14.sp
                                            : isSmall
                                                ? 16.sp
                                                : 18.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15.sp),
                                child: GestureDetector(
                                  onTap: () {
                                    if (dataProvider.soundOn == true) {
                                      dataProvider.initOnTap();
                                    }
                                    dataProvider.statisticsDialog = false;
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 45.sp,
                                    width: 120.w,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1.5.w, color: Colors.white),
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: dataProvider.backGround,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "BACK",
                                        style: GoogleFonts.lexend(
                                          fontSize: isIpad ? 18.sp : 22.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
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
}
