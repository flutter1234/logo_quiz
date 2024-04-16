import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logo_quiz/AdPlugin/Ads/Banner/BannerWrapper.dart';
import 'package:logo_quiz/AdPlugin/Ads/FullScreen/Ads.dart';
import 'package:logo_quiz/AdPlugin/MainJson/MainJson.dart';
import 'package:logo_quiz/Provider/api_provider.dart';
import 'package:logo_quiz/main.dart';
import 'package:provider/provider.dart';

class spin_screen extends StatefulWidget {
  static const routeName = '/spin_screen';

  const spin_screen({super.key});

  @override
  State<spin_screen> createState() => _spin_screenState();
}

class _spin_screenState extends State<spin_screen> {
  bool isLoading = true;
  bool collectDialog = false;
  int spinIndex = 0;
  List collectedList = [];

  @override
  void initState() {
    Api dataProvider = Provider.of<Api>(context, listen: false);

    context.read<Api>().spinData(context.read<MainJson>().data!['assets']['spinJson']).then((value) {
      isLoading = false;
    });
    dataProvider.coin = storage.read("coin") ?? 0;
    dataProvider.star = storage.read("star") ?? 0;

    collectedList = storage.read("collectedList") ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Api dataProvider = Provider.of<Api>(context, listen: true);
    return BannerWrapper(
      parentContext: context,
      child: Scaffold(
        backgroundColor: dataProvider.backGround,
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Stack(
                children: [
                  Padding(
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
                        SizedBox(height: 10.h),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
                            itemCount: dataProvider.spinList['data'].length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  index == 0 || dataProvider.spinList['data'][index]['spinDate'] != dataProvider.spinList['data'][index - 1]['spinDate']
                                      ? Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(5.sp),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(width: 1.w, color: Colors.white),
                                                  borderRadius: BorderRadius.circular(5.r),
                                                  color: dataProvider.levelContainer1,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
                                                  child: Center(
                                                    child: Text(
                                                      '${dataProvider.spinList['data'][index]['spinDate']}',
                                                      style: GoogleFonts.aboreto(
                                                        fontSize: 22.sp,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w900,
                                                        fontStyle: FontStyle.normal,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox.shrink(),
                                  Padding(
                                    padding: EdgeInsets.all(5.sp),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          spinIndex = index;
                                          if (!collectedList.contains(dataProvider.spinList['data'][index]['id'])) {
                                            AdsRN().showFullScreen(
                                              context: context,
                                              onComplete: () {
                                                collectDialog = true;
                                                setState(() {});
                                              },
                                            );
                                          }
                                        });
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 60.sp,
                                            width: 1.sw,
                                            decoration: BoxDecoration(
                                              border: Border.all(width: 1.w, color: Colors.white),
                                              borderRadius: BorderRadius.circular(6.r),
                                              color: dataProvider.levelContainer2,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 10.sp,
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    height: 45.sp,
                                                    width: 45.sp,
                                                    child: Image(
                                                      image: AssetImage('assets/images/coin.png'),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Text(
                                                        "${dataProvider.spinList['data'][index]['spinDate']}",
                                                        style: GoogleFonts.lexend(
                                                          fontSize: 22.sp,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${dataProvider.spinList['data'][index]['subject']}",
                                                        style: GoogleFonts.lexend(
                                                          fontSize: 20.sp,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    height: 30.sp,
                                                    width: 30.sp,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.black45,
                                                    ),
                                                    child: Icon(
                                                      Icons.arrow_forward,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          collectedList.contains(dataProvider.spinList['data'][index]['id'])
                                              ? Container(
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(5.r),
                                                    child: BackdropFilter(
                                                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                                      child: Container(
                                                        height: 60.sp,
                                                        width: 1.sw,
                                                        color: Colors.black.withOpacity(0.3),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  collectDialog == true
                      ? Container(
                          color: Colors.black54,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(15.sp),
                                child: Container(
                                  width: 1.sw,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 2.w, color: Colors.white),
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: dataProvider.backGround,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10.h),
                                      Text(
                                        '${dataProvider.spinList['data'][spinIndex]['spinDate']}',
                                        style: GoogleFonts.lexend(
                                          fontSize: 25.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image(
                                            height: 45.sp,
                                            width: 45.w,
                                            image: AssetImage('assets/images/coin.png'),
                                          ),
                                          SizedBox(width: 15.w),
                                          Text(
                                            '${dataProvider.spinList['data'][spinIndex]['subject']}',
                                            style: GoogleFonts.lexend(
                                              fontSize: 25.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 20.sp),
                                        child: Text(
                                          '${dataProvider.spinList['data'][spinIndex]['detail']}',
                                          style: GoogleFonts.lexend(
                                            fontSize: 18.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 30.sp, vertical: 20.sp),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                collectDialog = false;
                                                setState(() {});
                                              },
                                              child: Container(
                                                height: 40.sp,
                                                width: 105.w,
                                                decoration: BoxDecoration(
                                                  border: Border.all(width: 1.w, color: Colors.white),
                                                  borderRadius: BorderRadius.circular(8.r),
                                                  color: Colors.red,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Close',
                                                    style: GoogleFonts.lora(
                                                      fontSize: isSmall ? 16.sp : 20.sp,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w700,
                                                      fontStyle: FontStyle.normal,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (collectedList.contains(dataProvider.spinList['data'][spinIndex]['id'])) ...{
                                              Container(
                                                height: 40.sp,
                                                width: 105.w,
                                                decoration: BoxDecoration(
                                                  border: Border.all(width: 1.w, color: Colors.white),
                                                  borderRadius: BorderRadius.circular(8.r),
                                                  color: Colors.green,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Collected',
                                                    style: GoogleFonts.lora(
                                                      fontSize: isSmall ? 16.sp : 20.sp,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w700,
                                                      fontStyle: FontStyle.normal,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            } else ...{
                                              GestureDetector(
                                                onTap: () async {
                                                  AdsRN().showFullScreen(
                                                    context: context,
                                                    onComplete: () {
                                                      dataProvider.coin = dataProvider.coin + int.parse(dataProvider.spinList['data'][spinIndex]['codeUrl']);
                                                      storage.write("coin", dataProvider.coin);
                                                      collectedList.add(dataProvider.spinList['data'][spinIndex]['id']);
                                                      storage.write("collectedList", collectedList);
                                                      print("collectedList ====>> ${collectedList}");
                                                      collectDialog = false;
                                                      setState(() {});
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  height: 40.sp,
                                                  width: 105.w,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(width: 1.w, color: Colors.white),
                                                    borderRadius: BorderRadius.circular(8.r),
                                                    color: Colors.green,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Collect',
                                                      style: GoogleFonts.lora(
                                                        fontSize: isSmall ? 16.sp : 20.sp,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w700,
                                                        fontStyle: FontStyle.normal,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            }
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                ],
              ),
      ),
    );
  }
}
