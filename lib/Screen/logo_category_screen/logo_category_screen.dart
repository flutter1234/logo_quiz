import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logo_quiz/Screen/one_logo_screen/one_logo_screen.dart';

class logo_category_screen extends StatefulWidget {
  static const routeName = '/logo_category_screen';

  const logo_category_screen({super.key});

  @override
  State<logo_category_screen> createState() => _logo_category_screenState();
}

class _logo_category_screenState extends State<logo_category_screen> {
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
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
              height: 15.h,
            ),
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
                      Navigator.pushNamed(
                        context,
                        one_logo_screen.routeName,
                        arguments: {
                          "oneLogo": data['logoData'][index],
                        },
                      );
                      print("oneLogo ====>>>${data['logoData'][index]}");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: HexColor('3271a5'),
                            spreadRadius: 2,
                            offset: Offset(0, 4),
                          ),
                        ],
                        border: Border.all(width: 1.w, color: Colors.white),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(9.r),
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
