import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logo_quiz/AdPlugin/Ads/FullScreen/Ads.dart';
import 'package:logo_quiz/AdPlugin/MainJson/MainJson.dart';
import 'package:logo_quiz/Provider/api_provider.dart';
import 'package:logo_quiz/main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class one_logo_screen extends StatefulWidget {
  static const routeName = '/one_logo_screen';
  final oneData;
  final index;
  final length;

  const one_logo_screen({super.key, this.oneData, this.index, this.length});

  @override
  State<one_logo_screen> createState() => _one_logo_screenState();
}

class _one_logo_screenState extends State<one_logo_screen> {
  List wordList = [];
  List letterShuffle = [];
  int rn = 0;
  List correctList = [];
  math.Random random = math.Random();
  List alphabet = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
  List ansList = [];
  List filledAns = [];
  List boolList = [];
  bool logoIsComplete = false;
  int lifeLine = 5;
  int wordIn = 0;
  int letterIn = 0;
  List completeLogo = [];

  @override
  void initState() {
    Api dataProvider = Provider.of<Api>(context, listen: false);
    List ansList2 = [];
    print("length =====>>>${widget.length}");
    ansList = storage.read(widget.oneData['name']) ?? [];
    logoIsComplete = storage.read("BOOL-${widget.oneData['name']}") ?? false;
    filledAns = storage.read("filledAns-${widget.oneData['name']}") ?? [];
    lifeLine = storage.read("lifeLine-${widget.oneData['name']}") ?? 5;
    completeLogo = storage.read("LEVEL ${widget.index}") ?? [];
    dataProvider.totalHint = storage.read("totalHint") ?? 0;

    var shuffle2 = storage.read("shuffle-${widget.oneData['name']}") ?? [];

    dataProvider.coin = storage.read("coin") ?? 0;
    dataProvider.star = storage.read("star") ?? 0;
    for (var letters in widget.oneData['name'].split(' ')) {
      wordList.add(letters);
    }
    // print("wordList =====>>>>${wordList}");
    wordList.forEach((element) {
      List temp = [];
      List anstemp = [];
      List boolTemp = [];
      for (var letters in element.split('')) {
        temp.add(letters);
        letterShuffle.add(letters);
        anstemp.add({"ans": "", "index": 0, "color": null});
      }
      ansList2.add(anstemp);
      correctList.add(temp);
      boolTemp = List.generate(anstemp.length, (index) => false);
      boolList.add(boolTemp);
    });
    ansList.isEmpty ? ansList = ansList2 : null;
    // print("ansList ==>>${ansList}");
    // print("boolList =====>>${boolList}");
    // print("correctList ==>>>${correctList}");
    if (shuffle2.isEmpty) {
      rn = random.nextInt(23);
      letterShuffle.add(alphabet[rn]);
      letterShuffle.add(alphabet[rn + 1]);
      letterShuffle.add(alphabet[rn + 2]);
      letterShuffle.shuffle();
      storage.write("shuffle-${widget.oneData['name']}", letterShuffle);
    } else {
      letterShuffle = shuffle2;
    }
    initializeLifelines();
    super.initState();
  }

  void initializeLifelines() {
    DateTime currentDate = DateTime.now();
    // print("currentDate ======>>${currentDate}");
    DateTime? storedDate = storage.read('lastDate') != null ? DateTime.parse(storage.read('lastDate')) : null;
    // print("storedDate ======>>${storedDate}");

    if (storedDate == null || storedDate.year != currentDate.year || storedDate.month != currentDate.month || storedDate.day != currentDate.day) {
      if (currentDate != storedDate) {
        storage.write('lifeLine-${widget.oneData['name']}', 5);
      }
      storage.write('lastDate', currentDate.toIso8601String());
      setState(() {
        lifeLine = 5;
      });
    } else {
      setState(() {
        lifeLine = storage.read('lifeLine-${widget.oneData['name']}') ?? 5;
      });
    }
  }

  bool areAllWordsComplete() {
    for (int i = 0; i < ansList.length; i++) {
      for (int j = 0; j < ansList[i].length; j++) {
        if (ansList[i][j]['ans'] == correctList[i][j]) {
          boolList[i][j] = true;
          // print("boolList ===>>${boolList}");
        }
        if (ansList[i][j]['ans'] == "") {
          logoIsComplete == true ? null : logoIsComplete = false;
          storage.write("BOOL-${widget.oneData['name']}", logoIsComplete);
          return false;
        }
      }
    }
    logoIsComplete = true;
    storage.write("BOOL-${widget.oneData['name']}", logoIsComplete);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final oneData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Api dataProvider = Provider.of<Api>(context, listen: true);
    return Scaffold(
      backgroundColor: dataProvider.backGround,
      body: Padding(
        padding: EdgeInsets.only(
          top: isSmall
              ? 45.h
              : isIpad
                  ? 30.h
                  : 50.h,
        ),
        child: Stack(
          children: [
            Column(
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
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 30.sp,
                          width: 30.w,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.w, color: Colors.white),
                            // color: HexColor('0096C7'),
                            color: dataProvider.levelContainer2,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Icon(
                            Icons.arrow_back,
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
                  padding: EdgeInsets.only(top: 10.h),
                  child: Text(
                    "LEVEL ${widget.index}",
                    style: GoogleFonts.lexend(
                      fontSize: isSmall
                          ? 22.sp
                          : isIpad
                              ? 20.sp
                              : 25.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                LinearPercentIndicator(
                  lineHeight: 15.sp,
                  padding: EdgeInsets.symmetric(horizontal: 60.sp),
                  barRadius: Radius.circular(10.r),
                  percent: completeLogo.length / widget.length,
                  backgroundColor: Colors.black26,
                  progressColor: Colors.green,
                  center: Text(
                    "${completeLogo.length}/${widget.length}",
                    style: GoogleFonts.lexend(
                      fontSize: isSmall
                          ? 10.sp
                          : isIpad
                              ? 10.sp
                              : 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(left: 25.w, right: 8.w),
                  child: Row(
                    children: [
                      Spacer(),
                      Container(
                        height: isIpad ? 120.sp : 175.sp,
                        width: isIpad ? 120.w : 175.w,
                        decoration: BoxDecoration(
                          border: Border.all(width: 3.w, color: Colors.grey.shade600),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Screenshot(
                          controller: dataProvider.screenshotController,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7.r),
                            child: CachedNetworkImage(
                              imageUrl: oneData['oneLogo']['thumbnail'],
                              fit: BoxFit.fill,
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                                color: Colors.white,
                                size: 25.sp,
                              ),
                              placeholder: (context, url) => Container(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.w,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                SizedBox(height: isIpad ? 10.h : 20.h),
                Wrap(
                  runSpacing: 5,
                  spacing: 5,
                  children: List.generate(
                    correctList.length,
                    (wordIndex) {
                      return Container(
                        height: isIpad ? 26.sp : 30.sp,
                        margin: EdgeInsets.symmetric(horizontal: 5.sp),
                        child: Center(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: correctList[wordIndex].length,
                            itemBuilder: (context, letterIndex) {
                              return GestureDetector(
                                onTap: () {
                                  if (dataProvider.soundOn == true) {
                                    dataProvider.initOnTap();
                                  }
                                  if (ansList[wordIndex][letterIndex]['ans'] != "") {
                                    if (areAllWordsComplete() || (boolList[wordIndex][letterIndex] && logoIsComplete)) {
                                      if (correctList[wordIndex][letterIndex] != ansList[wordIndex][letterIndex]['ans']) {
                                        letterShuffle[ansList[wordIndex][letterIndex]['index']] = ansList[wordIndex][letterIndex]['ans'];
                                        filledAns.remove(ansList[wordIndex][letterIndex]['index']);
                                        ansList[wordIndex][letterIndex]['ans'] = "";
                                        ansList[wordIndex][letterIndex]['index'] = 0;
                                      }
                                    } else {
                                      letterShuffle[ansList[wordIndex][letterIndex]['index']] = ansList[wordIndex][letterIndex]['ans'];
                                      filledAns.remove(ansList[wordIndex][letterIndex]['index']);
                                      ansList[wordIndex][letterIndex]['ans'] = "";
                                      ansList[wordIndex][letterIndex]['index'] = 0;
                                    }
                                  }
                                  setState(() {});
                                  storage.write(widget.oneData['name'], ansList);
                                  storage.write("filledAns-${widget.oneData['name']}", filledAns);
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2.sp),
                                  child: Container(
                                    width: 30.w,
                                    decoration: BoxDecoration(
                                      color: areAllWordsComplete()
                                          ? ansList[wordIndex][letterIndex]['color'] == "green"
                                              ? Colors.green.shade700
                                              : Colors.red
                                          : ansList[wordIndex][letterIndex]['color'] == "green"
                                              ? Colors.green.shade700
                                              : Colors.white60,
                                      borderRadius: BorderRadius.circular(3.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        ansList[wordIndex][letterIndex]['ans'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: isIpad ? 18.sp : 22.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Spacer(),
                Stack(
                  alignment: Alignment.centerRight,
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      height: 20.sp,
                      child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 20.sp,
                            width: 40.w,
                            decoration: BoxDecoration(
                              // color: HexColor('4A148C'),
                              color: lifeLine <= index ? Colors.red : Colors.green.shade700,
                              border: Border.all(width: 1.w, color: Colors.grey.shade400),
                              borderRadius: index == 0
                                  ? BorderRadius.only(
                                      bottomLeft: Radius.circular(5.r),
                                      topLeft: Radius.circular(5.r),
                                    )
                                  : index == 4
                                      ? BorderRadius.only(
                                          topRight: Radius.circular(5.r),
                                          bottomRight: Radius.circular(5.r),
                                        )
                                      : BorderRadius.circular(0),
                            ),
                            child: Center(
                              child: Text(
                                "${index + 1}",
                                style: GoogleFonts.lexend(
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      right: -22.w,
                      child: Container(
                        height: 30.sp,
                        width: 30.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            width: 1.w,
                            color: Colors.red,
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(2.sp),
                              child: Image.asset("assets/images/heart.png"),
                            ),
                            Text(
                              "${lifeLine}",
                              style: GoogleFonts.lexend(
                                fontSize: 12.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (dataProvider.soundOn == true) {
                            dataProvider.initOnTap();
                          }
                          for (int i = 0; i < ansList.length; i++) {
                            for (int j = 0; j < ansList[i].length; j++) {
                              if (ansList[i][j]['color'] != "green") {
                                filledAns.remove(ansList[i][j]['index']);
                                ansList[i][j]['index'] = 0;
                                ansList[i][j]['ans'] = "";
                              }

                              setState(() {});
                            }
                          }

                          storage.write(widget.oneData['name'], ansList);
                          storage.write("filledAns-${widget.oneData['name']}", filledAns);
                        },
                        child: Container(
                          height: isIpad ? 30.sp : 40.sp,
                          width: isIpad ? 30.w : 40.w,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.w, color: Colors.white),
                            borderRadius: BorderRadius.circular(5.r),
                            color: dataProvider.levelContainer2,
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: isIpad ? 25.sp : 30.sp,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (dataProvider.soundOn == true) {
                            dataProvider.initOnTap();
                          }
                          for (int i = ansList.length - 1; i >= 0; i--) {
                            for (int j = ansList[i].length - 1; j >= 0; j--) {
                              if (ansList[i][j]['color'] != "green") {
                                if (ansList[i][j]['ans'].isNotEmpty) {
                                  letterShuffle[ansList[i][j]['index']] = ansList[i][j]['ans'];
                                  filledAns.remove(ansList[i][j]['index']);
                                  ansList[i][j]['ans'] = "";
                                  ansList[i][j]['index'] = 0;
                                  setState(() {});
                                  return;
                                }
                              }
                            }
                          }
                          storage.write(widget.oneData['name'], ansList);
                          storage.write("filledAns-${widget.oneData['name']}", filledAns);
                        },
                        child: Container(
                          height: isIpad ? 30.sp : 40.sp,
                          width: isIpad ? 30.w : 40.w,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.w, color: Colors.white),
                            borderRadius: BorderRadius.circular(5.r),
                            color: dataProvider.levelContainer2,
                          ),
                          child: Icon(
                            Icons.replay_rounded,
                            color: Colors.white,
                            size: isIpad ? 25.sp : 30.sp,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (dataProvider.soundOn == true) {
                            dataProvider.initOnTap();
                          }
                          if (dataProvider.coin >= 50) {
                            AdsRN().showFullScreen(
                              context: context,
                              onComplete: () {
                                String tempAns = "";
                                dataProvider.coin = dataProvider.coin - 50;
                                storage.write("coin", dataProvider.coin);
                                dataProvider.totalHint = dataProvider.totalHint + 1;
                                storage.write("totalHint", dataProvider.totalHint);

                                for (int i = 0; i < ansList.length; i++) {
                                  for (int j = 0; j < ansList[i].length; j++) {
                                    if (ansList[i][j]['ans'] == "") {
                                      ansList[i][j]['ans'] = correctList[i][j];
                                      for (int k = 0; k < letterShuffle.length; k++) {
                                        if (letterShuffle[k] == ansList[i][j]['ans'] && !(filledAns.contains(k))) {
                                          ansList[i][j]['index'] = k;
                                          filledAns.add(k);
                                          break;
                                        }
                                      }
                                      if ((areAllWordsComplete() || (boolList[i][j] && logoIsComplete)) &&
                                          ansList[i][j]['ans'] == correctList[i][j]) {
                                        if (!completeLogo.contains(widget.oneData['name'])) {
                                          completeLogo.add(widget.oneData['name']);

                                          dataProvider.coin = dataProvider.coin + 10;
                                          storage.write("coin", dataProvider.coin);
                                          if (completeLogo.length == widget.length) {
                                            dataProvider.star = dataProvider.star + 5;
                                            dataProvider.levelLength = dataProvider.levelLength + 1;
                                            setState(() {});
                                            storage.write("star", dataProvider.star);
                                            storage.write("levelLength", dataProvider.levelLength);
                                          }
                                        }
                                      }
                                      storage.write("LEVEL ${widget.index}", completeLogo);
                                      print("completeLogo ======>>>${completeLogo}");
                                      setState(() {});
                                      return;
                                    }
                                  }
                                }
                                for (int i = 0; i < correctList.length; i++) {
                                  for (int j = 0; j < correctList[i].length; j++) {
                                    tempAns = tempAns + ansList[i][j]['ans'];
                                    if (areAllWordsComplete()) {
                                      for (int k = 0; k < correctList.length; k++) {
                                        for (int l = 0; l < correctList[k].length; l++) {
                                          if (ansList[k][l]['ans'] == correctList[k][l]) {
                                            ansList[k][l]['color'] = "green";
                                            storage.write(widget.oneData['name'], ansList);
                                          }
                                        }
                                      }
                                    }
                                    if (tempAns == widget.oneData['name']) {
                                      if (!completeLogo.contains(widget.oneData['name'])) {
                                        completeLogo.add(widget.oneData['name']);
                                        storage.write("LEVEL ${widget.index}", completeLogo);
                                        print("completeLogo ======>>>${completeLogo}");
                                        dataProvider.coin = dataProvider.coin + 10;
                                        storage.write("coin", dataProvider.coin);
                                      }
                                    }
                                    if (completeLogo.length == widget.length) {
                                      dataProvider.star = dataProvider.star + 5;
                                      dataProvider.levelLength = dataProvider.levelLength + 1;
                                      setState(() {});
                                      storage.write("star", dataProvider.star);
                                      storage.write("levelLength", dataProvider.levelLength);
                                    }
                                  }
                                  if (i < correctList.length - 1) {
                                    tempAns = tempAns + " ";
                                  }
                                }
                              },
                            );
                          }
                          setState(() {});
                          storage.write(widget.oneData['name'], ansList);
                          storage.write("filledAns-${widget.oneData['name']}", filledAns);
                        },
                        child: Stack(
                          alignment: Alignment.topRight,
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: isIpad ? 30.sp : 40.sp,
                              width: isIpad ? 30.w : 40.w,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1.w, color: Colors.white),
                                borderRadius: BorderRadius.circular(5.r),
                                // color: dataProvider.levelContainer2,
                                color: dataProvider.coin >= 50 ? dataProvider.levelContainer2 : Colors.grey.shade500,
                              ),
                              child: Icon(
                                Icons.emoji_objects_outlined,
                                color: Colors.white,
                                size: isIpad ? 25.sp : 30.sp,
                              ),
                            ),
                            Positioned(
                              top: 5.h,
                              right: isIpad ? -25.w : -20.w,
                              child: Container(
                                height: isIpad ? 12.sp : 15.sp,
                                width: 30.sp,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5.r),
                                    bottomRight: Radius.circular(5.r),
                                  ),
                                  color: Colors.green.shade700,
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(1.2.sp),
                                      child: Image(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          'assets/images/spin.png',
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "50",
                                      style: GoogleFonts.lexend(
                                        fontSize: isIpad ? 8.sp : 10.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.sp),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 5,
                    spacing: 5,
                    children: List.generate(
                      letterShuffle.length,
                      (index) {
                        return GestureDetector(
                          onTap: lifeLine > 0
                              ? () {
                                  if (dataProvider.soundOn == true) {
                                    dataProvider.initOnTap();
                                  }
                                  String tempAns = "";
                                  loop:
                                  for (int i = 0; i < correctList.length; i++) {
                                    for (int j = 0; j < correctList[i].length; j++) {
                                      if (ansList[i][j]['ans'] == "") {
                                        ansList[i][j]['ans'] = letterShuffle[index];
                                        ansList[i][j]['index'] = index;
                                        filledAns.add(index);
                                        setState(() {});
                                        storage.write(widget.oneData['name'], ansList);
                                        storage.write("filledAns-${widget.oneData['name']}", filledAns);
                                        break loop;
                                      }
                                    }
                                  }
                                  for (int i = 0; i < correctList.length; i++) {
                                    for (int j = 0; j < correctList[i].length; j++) {
                                      tempAns = tempAns + ansList[i][j]['ans'];
                                      if (areAllWordsComplete()) {
                                        for (int k = 0; k < correctList.length; k++) {
                                          for (int l = 0; l < correctList[k].length; l++) {
                                            if (ansList[k][l]['ans'] == correctList[k][l]) {
                                              ansList[k][l]['color'] = "green";
                                              storage.write(widget.oneData['name'], ansList);
                                            }
                                          }
                                        }
                                      }
                                      if (tempAns == widget.oneData['name']) {
                                        if (!completeLogo.contains(widget.oneData['name'])) {
                                          completeLogo.add(widget.oneData['name']);
                                          storage.write("LEVEL ${widget.index}", completeLogo);
                                          print("completeLogo ======>>>${completeLogo}");
                                          dataProvider.coin = dataProvider.coin + 10;
                                          storage.write("coin", dataProvider.coin);
                                        }
                                      }
                                      if (completeLogo.length > widget.length / 2) {
                                        if (!dataProvider.lockList.contains("LEVEL ${widget.index + 1}")) {
                                          dataProvider.lockList.add("LEVEL ${widget.index + 1}");
                                        }
                                        setState(() {});
                                        storage.write("lockList", dataProvider.lockList);
                                        print("lockList ====>>${dataProvider.lockList}");
                                      }
                                      if (completeLogo.length == widget.length) {
                                        dataProvider.star = dataProvider.star + 5;
                                        dataProvider.levelLength = dataProvider.levelLength + 1;
                                        setState(() {});
                                        storage.write("star", dataProvider.star);
                                        storage.write("levelLength", dataProvider.levelLength);
                                      }
                                    }
                                    if (i < correctList.length - 1) {
                                      tempAns = tempAns + " ";
                                    }
                                  }
                                  print(ansList);
                                  print(correctList);
                                  print(tempAns);
                                  if (tempAns != widget.oneData['name']) {
                                    if (lifeLine != 0) {
                                      if (areAllWordsComplete()) {
                                        lifeLine--;
                                        dataProvider.failedAttempts = dataProvider.failedAttempts + 1;
                                        print("failedAttempts =====>>${dataProvider.failedAttempts}");
                                        setState(() {});
                                      }
                                    }
                                    storage.write("lifeLine-${widget.oneData['name']}", lifeLine);
                                    storage.write("failedAttempts", dataProvider.failedAttempts);
                                  }
                                  setState(() {});
                                }
                              : () {},
                          child: filledAns.contains(index)
                              ? SizedBox(
                                  height: isIpad ? 30.sp : 40.sp,
                                  width: isIpad ? 30.w : 40.w,
                                )
                              : Container(
                                  width: isIpad ? 30.sp : 40.w,
                                  height: isIpad ? 30.w : 40.sp,
                                  decoration: BoxDecoration(
                                    color: lifeLine > 0 ? Colors.white : Colors.grey.shade500,
                                    border: Border.all(width: 1.w, color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Center(
                                    child: Text(
                                      letterShuffle[index],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: isIpad ? 18.sp : 22.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
            Positioned(
              top: isSmall
                  ? 1.sh / 3
                  : isIpad
                      ? 1.sh / 3
                      : 1.sh / 4,
              left: 18.w,
              right: 18.w,
              child: Builder(
                builder: (contexts) {
                  return Container(
                    width: 1.sw,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (dataProvider.soundOn == true) {
                              dataProvider.initOnTap();
                            }
                            setState(() {
                              dataProvider.shareImage(contexts);
                            });
                          },
                          child: Container(
                            height: isIpad ? 35.sp : 42.sp,
                            width: isIpad ? 35.sp : 42.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                width: 2.w,
                                color: dataProvider.levelContainer2,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(5.sp),
                              child: Image.asset("assets/images/share.png"),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: context.read<MainJson>().data![context.read<MainJson>().version!]['videoSpin'] == true
                              ? () {
                                  if (dataProvider.soundOn == true) {
                                    dataProvider.initOnTap();
                                  }
                                  AdsRN().showFullScreen(
                                    context: context,
                                    onComplete: () {
                                      dataProvider.coin = dataProvider.coin + 25;
                                      storage.write("coin", dataProvider.coin);
                                      setState(() {});
                                    },
                                  );
                                }
                              : () {},
                          child: Container(
                            height: isIpad ? 35.sp : 42.sp,
                            width: isIpad ? 35.sp : 42.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.read<MainJson>().data![context.read<MainJson>().version!]['videoSpin'] == true
                                  ? Colors.white
                                  : Colors.grey.shade400,
                              border: Border.all(
                                width: 2.w,
                                color: dataProvider.levelContainer2,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(5.sp),
                              child: Transform.rotate(
                                angle: -0.3,
                                child: Image.asset("assets/images/video.png"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
