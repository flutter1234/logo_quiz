import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logo_quiz/Provider/api_provider.dart';
import 'package:logo_quiz/Screen/logo_category_screen/logo_category_screen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class levels_screen extends StatefulWidget {
  static const routeName = '/levels_screen';

  const levels_screen({super.key});

  @override
  State<levels_screen> createState() => _levels_screenState();
}

class _levels_screenState extends State<levels_screen> {
  void initState() {
    super.initState();
    Api dataProvider = Provider.of<Api>(context, listen: false);
    dataProvider.mainLevel = List.filled(dataProvider.wordList['word'].length, false);
    dataProvider.coin = storage.read("coin") ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    Api dataProvider = Provider.of<Api>(context, listen: true);
    return Scaffold(
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
                    onTap: () {
                      Navigator.pop(context);
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
            Expanded(
              child: GridView.builder(
                itemCount: dataProvider.wordList['word'].length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.sp,
                  mainAxisSpacing: 15.sp,
                  mainAxisExtent: 160.sp,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                itemBuilder: (context, index) {
                  List completeLogo = storage.read("LEVEL ${index + 1}") ?? [];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        logo_category_screen.routeName,
                        arguments: {
                          "logoData": dataProvider.wordList['word'][index]['Level ${index + 1}'],
                          "Index": index,
                        },
                      ).then((value) {
                        setState(() {
                          completeLogo = storage.read("LEVEL ${index + 1}") ?? [];
                        });
                      });
                      // print("wordList ========>>>${dataProvider.wordList['word'][index]['Level ${index + 1}']}");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            dataProvider.levelContainer1,
                            dataProvider.levelContainer2,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: dataProvider.levelContainer2,
                            offset: Offset(0, 4),
                          ),
                        ],
                        border: Border.all(width: 0.3.w, color: Colors.white70),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: Container(
                                height: 100.sp,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(9.r),
                                  child: CachedNetworkImage(
                                    imageUrl: dataProvider.wordList['word'][index]['image'],
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
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: Text(
                                "LEVEL ${index + 1}",
                                style: GoogleFonts.lexend(
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.centerRight,
                              clipBehavior: Clip.none,
                              children: [
                                LinearPercentIndicator(
                                    width: 150.w,
                                    lineHeight: 15.sp,
                                    barRadius: Radius.circular(10.r),
                                    percent: completeLogo.length / dataProvider.wordList['word'][index]['Level ${index + 1}'].length,
                                    backgroundColor: Colors.black26,
                                    progressColor: Colors.green,
                                    center: (completeLogo.length != dataProvider.wordList['word'][index]['Level ${index + 1}'].length)
                                        ? Text(
                                            "${completeLogo.length}/${dataProvider.wordList['word'][index]['Level ${index + 1}'].length}",
                                            style: GoogleFonts.lexend(
                                              fontSize: 12.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        : Text(
                                            "Done",
                                            style: GoogleFonts.lexend(
                                              fontSize: 12.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )),
                                if (completeLogo.length == dataProvider.wordList['word'][index]['Level ${index + 1}'].length)
                                  Positioned(
                                    right: 10.w,
                                    child: Container(
                                      height: 22.sp,
                                      width: 22.sp,
                                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                                      child: Icon(
                                        Icons.check,
                                        size: 15.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
