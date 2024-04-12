import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logo_quiz/main.dart';

class one_logo_screen extends StatefulWidget {
  static const routeName = '/one_logo_screen';
  final oneData;

  const one_logo_screen({super.key, this.oneData});

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

  @override
  void initState() {
    List ansList2 = [];
    ansList = storage.read(widget.oneData['name']) ?? [];
    logoIsComplete = storage.read("BOOL-${widget.oneData['name']}") ?? false;
    for (var letters in widget.oneData['name'].split(' ')) {
      wordList.add(letters);
    }
    print("wordList =====>>>>${wordList}");

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
    print("ansList ==>>${ansList}");
    print("boolList =====>>${boolList}");
    print("correctList ==>>>${correctList}");
    rn = random.nextInt(23);
    letterShuffle.add(alphabet[rn]);
    letterShuffle.add(alphabet[rn + 1]);
    letterShuffle.add(alphabet[rn + 2]);
    letterShuffle.shuffle();
    super.initState();
  }

  bool areAllWordsComplete() {
    for (int i = 0; i < ansList.length; i++) {
      for (int j = 0; j < ansList[i].length; j++) {
        if (ansList[i][j]['ans'] == correctList[i][j]) {
          boolList[i][j] = true;
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
    // print(ansList);
    // print(correctList);
    // print(areAllWordsComplete());
    return Scaffold(
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
                            border: Border.all(width: 0.8.w, color: Colors.black54),
                            color: HexColor('0096C7'),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            size: 22.sp,
                            color: HexColor('023E8A'),
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
                              border: Border.all(width: 2.w, color: HexColor('0096C7')),
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Center(
                              child: Text(
                                "50",
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
                              border: Border.all(width: 2.w, color: HexColor('0096C7')),
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
                                    "100",
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
                SizedBox(
                  height: 25.h,
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7.r),
                          child: CachedNetworkImage(
                            imageUrl: oneData['oneLogo']['thumbnail'],
                            fit: BoxFit.cover,
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
                              color: Colors.green.shade700,
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
                              "5",
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
                          if (areAllWordsComplete()) {
                            for (int i = 0; i < ansList.length; i++) {
                              for (int j = 0; j < ansList[i].length; j++) {
                                if (ansList[i][j]['ans'] != correctList[i][j]) {
                                  filledAns.remove(ansList[i][j]['index']);
                                  ansList[i][j]['index'] = 0;
                                  ansList[i][j]['ans'] = "";
                                }
                                setState(() {});
                              }
                            }
                          } else {
                            for (int i = 0; i < ansList.length; i++) {
                              for (int j = 0; j < ansList[i].length; j++) {
                                filledAns = [];
                                ansList[i][j]['index'] = 0;
                                ansList[i][j]['ans'] = "";
                                setState(() {});
                              }
                            }
                          }
                          storage.write(widget.oneData['name'], ansList);
                        },
                        child: Container(
                          height: 40.sp,
                          width: 40.w,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.w, color: Colors.white),
                            borderRadius: BorderRadius.circular(5.r),
                            color: HexColor('4169E1'),
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
                          storage.write(widget.oneData['name'], ansList);
                        },
                        child: Container(
                          height: 40.sp,
                          width: 40.w,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.w, color: Colors.white),
                            borderRadius: BorderRadius.circular(5.r),
                            color: HexColor('4169E1'),
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
                                setState(() {});
                                return;
                              }
                            }
                          }
                          setState(() {});
                          storage.write(widget.oneData['name'], ansList);
                        },
                        child: Container(
                          height: 40.sp,
                          width: 40.w,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.w, color: Colors.white),
                            borderRadius: BorderRadius.circular(5.r),
                            color: HexColor('4169E1'),
                          ),
                          child: Icon(
                            Icons.emoji_objects_outlined,
                            color: Colors.white,
                            size: 30.sp,
                          ),
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
                          onTap: () {
                            for (int i = 0; i < ansList.length; i++) {
                              for (int j = 0; j < ansList[i].length; j++) {
                                if (ansList[i][j]['ans'] == "") {
                                  ansList[i][j]['ans'] = letterShuffle[index];
                                  ansList[i][j]['index'] = index;
                                  filledAns.add(index);
                                  setState(() {});
                                  storage.write(widget.oneData['name'], ansList);
                                  return;
                                }
                              }
                            }
                          },
                          child: filledAns.contains(index)
                              ? SizedBox(
                                  height: 40.sp,
                                  width: 40.w,
                                )
                              : Container(
                                  width: 40.w,
                                  height: 40.sp,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
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
                    Stack(
                      alignment: Alignment.bottomCenter,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 42.sp,
                          width: 42.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              width: 1.w,
                              color: Colors.white,
                            ),
                          ),
                          child: Image.asset("assets/images/spinning_wheel.png"),
                        ),
                        Positioned(
                          bottom: -5.h,
                          child: Container(
                            height: 15.sp,
                            width: 42.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.r),
                              color: Colors.green,
                              border: Border.all(
                                width: 0.5.w,
                                color: Colors.white,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "SPIN",
                                style: GoogleFonts.lexend(
                                  fontSize: 10.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 42.sp,
                      width: 42.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          width: 3.w,
                          color: Colors.blueAccent.shade400,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(4.sp),
                        child: Transform.rotate(
                          angle: -0.3,
                          child: Image.asset("assets/images/video.png"),
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
