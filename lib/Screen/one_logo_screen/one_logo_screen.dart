import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logo_quiz/AdPlugin/Ads/FullScreen/Ads.dart';
import 'package:logo_quiz/AdPlugin/MainJson/MainJson.dart';
import 'package:logo_quiz/Provider/api_provider.dart';
import 'package:logo_quiz/main.dart';
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

    ansList = storage.read(widget.oneData['name']) ?? [];
    logoIsComplete = storage.read("BOOL-${widget.oneData['name']}") ?? false;
    filledAns = storage.read("filledAns-${widget.oneData['name']}") ?? [];
    lifeLine = storage.read("lifeLine-${widget.oneData['name']}") ?? 5;
    completeLogo = storage.read("LEVEL ${widget.index}") ?? [];
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
        anstemp.add({"ans": "", "index": 0});
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
        padding: EdgeInsets.only(top: 50.h),
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
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Text(
                    "LEVEL ${widget.index}",
                    style: GoogleFonts.lexend(
                      fontSize: 25.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.w, right: 8.w),
                  child: Row(
                    children: [
                      Spacer(),
                      Container(
                        height: 175.sp,
                        width: 175.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
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
                SizedBox(height: 20.h),
                Wrap(
                  runSpacing: 5,
                  spacing: 5,
                  children: List.generate(
                    correctList.length,
                    (wordIndex) {
                      return Container(
                        height: 30.w,
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
                                      color: areAllWordsComplete() || (boolList[wordIndex][letterIndex] && logoIsComplete)
                                          ? ansList[wordIndex][letterIndex]['ans'] == correctList[wordIndex][letterIndex]
                                              ? Colors.green
                                              : ansList[wordIndex][letterIndex]['ans'] == ""
                                                  ? Colors.white70
                                                  : Colors.red
                                          : logoIsComplete == false || ansList[wordIndex][letterIndex]['ans'] == ""
                                              ? Colors.white70
                                              : Colors.red,
                                      borderRadius: BorderRadius.circular(3.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        ansList[wordIndex][letterIndex]['ans'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22.sp,
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
                          for (int i = 0; i < ansList.length; i++) {
                            for (int j = 0; j < ansList[i].length; j++) {
                              if (correctList[i][j] != ansList[i][j]['ans']) {
                                if (ansList[i][j]['ans'] != correctList[i][j]) {
                                  filledAns.remove(ansList[i][j]['index']);
                                  ansList[i][j]['index'] = 0;
                                  ansList[i][j]['ans'] = "";
                                }
                              }
                              // logoIsComplete = false;
                              // storage.write("BOOL-${widget.oneData['name']}", logoIsComplete);
                              setState(() {});
                            }
                          }

                          storage.write(widget.oneData['name'], ansList);
                          storage.write("filledAns-${widget.oneData['name']}", filledAns);
                        },
                        child: Container(
                          height: 40.sp,
                          width: 40.w,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.w, color: Colors.white),
                            borderRadius: BorderRadius.circular(5.r),
                            color: dataProvider.levelContainer2,
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 30.sp,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          for (int i = ansList.length - 1; i >= 0; i--) {
                            for (int j = ansList[i].length - 1; j >= 0; j--) {
                              if (correctList[i][j] != ansList[i][j]['ans']) {
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
                          height: 40.sp,
                          width: 40.w,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.w, color: Colors.white),
                            borderRadius: BorderRadius.circular(5.r),
                            color: dataProvider.levelContainer2,
                          ),
                          child: Icon(
                            Icons.replay_rounded,
                            color: Colors.white,
                            size: 30.sp,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (dataProvider.coin > 50) {
                            AdsRN().showFullScreen(
                              context: context,
                              onComplete: () {
                                dataProvider.coin = dataProvider.coin - 50;
                                storage.write("coin", dataProvider.coin);
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
                                      if ((areAllWordsComplete() || (boolList[i][j] && logoIsComplete)) && ansList[i][j]['ans'] == correctList[i][j]) {
                                        if (!completeLogo.contains(widget.oneData['name'])) {
                                          completeLogo.add(widget.oneData['name']);

                                          dataProvider.coin = dataProvider.coin + 10;
                                          storage.write("coin", dataProvider.coin);
                                          if (completeLogo.length == widget.length) {
                                            dataProvider.star = dataProvider.star + 5;
                                            storage.write("star", dataProvider.star);
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
                              height: 40.sp,
                              width: 40.w,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1.w, color: Colors.white),
                                borderRadius: BorderRadius.circular(5.r),
                                // color: dataProvider.levelContainer2,
                                color: dataProvider.coin > 50 ? dataProvider.levelContainer2 : Colors.grey.shade500,
                              ),
                              child: Icon(
                                Icons.emoji_objects_outlined,
                                color: Colors.white,
                                size: 30.sp,
                              ),
                            ),
                            Positioned(
                              top: 5.h,
                              right: -20.w,
                              child: Container(
                                height: 15.sp,
                                width: 30.sp,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5.r),
                                    bottomRight: Radius.circular(5.r),
                                  ),
                                  color: Colors.green,
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(2.sp),
                                      child: Image(
                                        image: AssetImage(
                                          'assets/images/coin.png',
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "50",
                                      style: GoogleFonts.lexend(
                                        fontSize: 10.sp,
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
                                  for (int i = 0; i < ansList.length; i++) {
                                    for (int j = 0; j < ansList[i].length; j++) {
                                      if (ansList[i][j]['ans'] == "") {
                                        ansList[i][j]['ans'] = letterShuffle[index];
                                        ansList[i][j]['index'] = index;
                                        filledAns.add(index);
                                        if ((areAllWordsComplete() || (boolList[i][j] && logoIsComplete)) && (ansList[i][j]['ans'] == correctList[i][j])) {
                                          if (!completeLogo.contains(widget.oneData['name'])) {
                                            completeLogo.add(widget.oneData['name']);
                                            storage.write("LEVEL ${widget.index}", completeLogo);
                                            print("completeLogo ======>>>${completeLogo}");
                                            dataProvider.coin = dataProvider.coin + 10;
                                            storage.write("coin", dataProvider.coin);
                                          }
                                        }
                                        setState(() {});
                                        storage.write(widget.oneData['name'], ansList);
                                        storage.write("filledAns-${widget.oneData['name']}", filledAns);

                                        if (lifeLine != 0) {
                                          areAllWordsComplete() ? lifeLine-- : null;
                                        }
                                        storage.write("lifeLine-${widget.oneData['name']}", lifeLine);
                                        return;
                                      }
                                    }
                                  }
                                }
                              : () {},
                          child: filledAns.contains(index)
                              ? SizedBox(
                                  height: 40.sp,
                                  width: 40.w,
                                )
                              : Container(
                                  width: 40.w,
                                  height: 40.sp,
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
                                        fontSize: 22.sp,
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
              top: 1.sh / 4,
              left: 18.w,
              right: 18.w,
              child: Container(
                width: 1.sw,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          dataProvider.shareImage();
                        });
                      },
                      child: Container(
                        height: 42.sp,
                        width: 42.w,
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
                      onTap: context.read<MainJson>().data![context.read<MainJson>().version!]['globalConfig']['globalAdFlag'] == true
                          ? () {
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
                        height: 42.sp,
                        width: 42.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.read<MainJson>().data![context.read<MainJson>().version!]['globalConfig']['globalAdFlag'] == true ? Colors.white : Colors.grey.shade400,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
