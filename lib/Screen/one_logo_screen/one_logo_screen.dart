import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

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

  @override
  void initState() {
    for (var letters in widget.oneData['name'].split(' ')) {
      wordList.add(letters);
    }
    print("wordList =====>>>>${wordList}");

    wordList.forEach((element) {
      List temp = [];
      List anstemp = [];
      for (var letters in element.split('')) {
        temp.add(letters);
        letterShuffle.add(letters);
        anstemp.add({"ans": "", "index": 0});
      }
      ansList.add(anstemp);
      correctList.add(temp);
    });

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
        if (ansList[i][j]['ans'] == "") {
          return false;
        }
      }
    }

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
        child: Column(
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
                  Container(
                    height: 30.sp,
                    width: 100.w,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.w, color: HexColor('0096C7')),
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "100",
                            style: GoogleFonts.lexend(
                              fontSize: 20.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
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
                  )
                ],
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(
                        width: 25.w,
                        child: ListView.builder(
                          itemCount: 5,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 20.h),
                          itemBuilder: (context, index) {
                            return Container(
                              height: 35.sp,
                              decoration: BoxDecoration(
                                color: HexColor('4A148C'),
                                border: Border.all(width: 1.w, color: Colors.grey.shade400),
                                borderRadius: index == 0
                                    ? BorderRadius.only(
                                        topLeft: Radius.circular(8.r),
                                        topRight: Radius.circular(8.r),
                                      )
                                    : index == 4
                                        ? BorderRadius.only(
                                            bottomLeft: Radius.circular(8.r),
                                            bottomRight: Radius.circular(8.r),
                                          )
                                        : BorderRadius.circular(0),
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: -18.h,
                        child: Container(
                          height: 32.sp,
                          width: 32.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              width: 1.5.w,
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
                  Container(
                    height: 170.sp,
                    width: 170.w,
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
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: correctList[wordIndex].length,
                      itemBuilder: (context, letterIndex) {
                        return GestureDetector(
                          onTap: () {
                            if (ansList[wordIndex][letterIndex]['ans'] != "") {
                              letterShuffle[ansList[wordIndex][letterIndex]['index']] = ansList[wordIndex][letterIndex]['ans'];
                              filledAns.remove(ansList[wordIndex][letterIndex]['index']);
                              ansList[wordIndex][letterIndex]['ans'] = "";
                              ansList[wordIndex][letterIndex]['index'] = 0;
                            }
                            setState(() {});
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.sp),
                            child: Container(
                              width: 30.w,
                              decoration: BoxDecoration(
                                color: areAllWordsComplete()
                                    ? ansList[wordIndex][letterIndex]['ans'] == correctList[wordIndex][letterIndex]
                                        ? Colors.green
                                        : ansList[wordIndex][letterIndex]['ans'] == ""
                                            ? Colors.white70
                                            : Colors.red
                                    : Colors.white70,
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
                  );
                },
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.sp),
              child: Wrap(
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
      ),
    );
  }
}
