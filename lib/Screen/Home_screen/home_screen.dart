import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logo_quiz/Provider/api_provider.dart';
import 'package:logo_quiz/Screen/logo_category_screen/logo_category_screen.dart';
import 'package:provider/provider.dart';

class home_screen extends StatefulWidget {
  static const routeName = '/home_screen';

  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  @override
  Widget build(BuildContext context) {
    Api dataProvider = Provider.of<Api>(context, listen: true);

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
                  Container(
                    height: 30.sp,
                    width: 30.w,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.8.w, color: Colors.black54),
                      color: HexColor('0096C7'),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Icon(
                      Icons.settings,
                      size: 22.sp,
                      color: HexColor('023E8A'),
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
              height: 15.h,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: dataProvider.wordList['word'].length,
                padding: EdgeInsets.only(top: 15.h),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          logo_category_screen.routeName,
                          arguments: {"logoData": dataProvider.wordList['word'][index]['Level ${index + 1}']},
                        );
                        // print("wordList ========>>>${dataProvider.wordList['word'][index]['Level ${index + 1}']}");
                      },
                      child: Container(
                        height: 60.sp,
                        width: 1.sw,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              HexColor('3271a5'),
                              HexColor('46a2da'),
                            ],
                          ),
                          border: Border.all(width: 1.w, color: Colors.white70),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "LEVEL ${index + 1}",
                              style: GoogleFonts.lexend(
                                fontSize: 22.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
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
