import 'package:cached_network_image/cached_network_image.dart';
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
                        Icons.settings,
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
            SizedBox(height: 15.h),
            Expanded(
              child: GridView.builder(
                itemCount: dataProvider.wordList['word'].length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.sp,
                  mainAxisSpacing: 15.sp,
                  mainAxisExtent: 150.sp,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        logo_category_screen.routeName,
                        arguments: {"logoData": dataProvider.wordList['word'][index]['Level ${index + 1}']},
                      );
                      // print("wordList ========>>>${dataProvider.wordList['word'][index]['Level ${index + 1}']}");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            HexColor('3271a5'),
                            HexColor('46a2da'),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: HexColor('3271a5'),
                            spreadRadius: 2,
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
                                height: 90.sp,
                                width: 90.w,
                                decoration: BoxDecoration(
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.white,
                                  //     spreadRadius: 2,
                                  //     offset: Offset(-4, 4),
                                  //   ),
                                  //   BoxShadow(
                                  //     color: Colors.grey.shade400,
                                  //     spreadRadius: 2,
                                  //     offset: Offset(-4, 4),
                                  //   ),
                                  // ],
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
                            Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: Container(
                                height: 22.sp,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.r),
                                  color: Colors.black45,
                                  border: Border.all(
                                    width: 1.w,
                                    color: Colors.black45,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "6/${dataProvider.wordList['word'][index]['Level ${index + 1}'].length}",
                                      style: GoogleFonts.lexend(
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
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
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: dataProvider.wordList['word'].length,
            //     padding: EdgeInsets.only(top: 15.h),
            //     itemBuilder: (context, index) {
            //       return Padding(
            //         padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 8.sp),
            //         child: GestureDetector(
            //           onTap: () {
            //             Navigator.pushNamed(
            //               context,
            //               logo_category_screen.routeName,
            //               arguments: {"logoData": dataProvider.wordList['word'][index]['Level ${index + 1}']},
            //             );
            //             // print("wordList ========>>>${dataProvider.wordList['word'][index]['Level ${index + 1}']}");
            //           },
            //           child: Container(
            //             height: 70.sp,
            //             width: 1.sw,
            //             decoration: BoxDecoration(
            //               gradient: LinearGradient(
            //                 begin: Alignment.bottomLeft,
            //                 end: Alignment.topRight,
            //                 colors: [
            //                   HexColor('3271a5'),
            //                   HexColor('46a2da'),
            //                 ],
            //               ),
            //               boxShadow: [
            //                 BoxShadow(
            //                   color: HexColor('3271a5'),
            //                   spreadRadius: 2,
            //                   offset: Offset(0, 4),
            //                 ),
            //               ],
            //               border: Border.all(width: 0.3.w, color: Colors.white70),
            //               borderRadius: BorderRadius.circular(5.r),
            //             ),
            //             child: Row(
            //               children: [
            //                 Transform.rotate(
            //                   angle: -0.3,
            //                   child: Container(
            //                     height: 55.sp,
            //                     width: 55.w,
            //                     decoration: BoxDecoration(
            //                       boxShadow: [
            //                         BoxShadow(
            //                           color: Colors.white,
            //                           spreadRadius: 2,
            //                           offset: Offset(-4, 4),
            //                         ),
            //                         BoxShadow(
            //                           color: Colors.grey.shade400,
            //                           spreadRadius: 2,
            //                           offset: Offset(-4, 4),
            //                         ),
            //                       ],
            //                       borderRadius: BorderRadius.circular(5.r),
            //                     ),
            //                     child: ClipRRect(
            //                       borderRadius: BorderRadius.circular(4.r),
            //                       child: CachedNetworkImage(
            //                         imageUrl: dataProvider.wordList['word'][index]['image'],
            //                         fit: BoxFit.cover,
            //                         errorWidget: (context, url, error) => Icon(
            //                           Icons.error,
            //                           color: Colors.white,
            //                           size: 25.sp,
            //                         ),
            //                         placeholder: (context, url) => Container(
            //                           child: Center(
            //                             child: CircularProgressIndicator(
            //                               color: Colors.white,
            //                               strokeWidth: 2.w,
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //                 Text(
            //                   "LEVEL ${index + 1}",
            //                   style: GoogleFonts.lexend(
            //                     fontSize: 22.sp,
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.w700,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
