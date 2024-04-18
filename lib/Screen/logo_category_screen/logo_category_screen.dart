import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logo_quiz/AdPlugin/Ads/Banner/BannerWrapper.dart';
import 'package:logo_quiz/AdPlugin/Ads/FullScreen/Ads.dart';
import 'package:logo_quiz/Provider/api_provider.dart';
import 'package:logo_quiz/Screen/one_logo_screen/one_logo_screen.dart';
import 'package:logo_quiz/main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class logo_category_screen extends StatefulWidget {
  static const routeName = '/logo_category_screen';

  const logo_category_screen({super.key});

  @override
  State<logo_category_screen> createState() => _logo_category_screenState();
}

class _logo_category_screenState extends State<logo_category_screen> {
  var data;
  List completeLogo = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Api dataProvider = Provider.of<Api>(context, listen: false);
      data = ModalRoute.of(context)!.settings.arguments;
      dataProvider.subLevel = List.filled(data['logoData'].length, false);
      completeLogo = storage.read("LEVEL ${data['Index'] + 1}") ?? [];
      dataProvider.coin = storage.read("coin") ?? 0;
      dataProvider.star = storage.read("star") ?? 0;
      setState(() {});
      // print("subLevel =======>>>>>>>>${dataProvider.subLevel.length}");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Api dataProvider = Provider.of<Api>(context, listen: true);

    data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return BannerWrapper(
      parentContext: context,
      child: Scaffold(
        backgroundColor: dataProvider.backGround,
        body: Padding(
          padding: EdgeInsets.only(
            top: isSmall
                ? 30.h
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
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Text(
                  "LEVEL ${data['Index'] + 1}",
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
                percent: completeLogo.length / data['logoData'].length,
                backgroundColor: Colors.black26,
                progressColor: Colors.green,
                center: Text(
                  "${completeLogo.length}/${data['logoData'].length}",
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
              SizedBox(height: 15.h),
              Expanded(
                child: GridView.builder(
                  itemCount: data['logoData'].length,
                  padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 15.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 100.sp,
                    mainAxisSpacing: 15.sp,
                    crossAxisSpacing: 15.sp,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (dataProvider.soundOn == true) {
                          dataProvider.initOnTap();
                        }
                        AdsRN().showFullScreen(
                          context: context,
                          onComplete: () {
                            Navigator.pushNamed(
                              context,
                              one_logo_screen.routeName,
                              arguments: {
                                "oneLogo": data['logoData'][index],
                                "Index": data['Index'] + 1,
                                "Length": data['logoData'].length,
                              },
                            ).then((value) {
                              setState(() {
                                completeLogo = storage.read("LEVEL ${data['Index'] + 1}") ?? [];
                              });
                            });
                          },
                        );
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            height: 100.sp,
                            width: 100.sp,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2.w, color: Colors.white),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(isIpad ? 7.r : 8.r),
                              child: CachedNetworkImage(
                                imageUrl: data['logoData'][index]['thumbnail'],
                                fit: BoxFit.fill,
                                errorWidget: (context, url, error) => Icon(
                                  Icons.error,
                                  size: 25.sp,
                                  color: Colors.white,
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
                          if (completeLogo.contains(data['logoData'][index]['name']))
                            Container(
                              height: 100.sp,
                              width: 100.sp,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                          if (completeLogo.contains(data['logoData'][index]['name']))
                            Padding(
                              padding: EdgeInsets.all(4.sp),
                              child: Container(
                                height: 20.sp,
                                width: 20.sp,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 0.5.w, color: Colors.white),
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                child: Icon(
                                  Icons.check,
                                  size: 15.sp,
                                  color: Colors.white,
                                ),
                              ),
                            )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
