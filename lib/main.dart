import 'package:dart_ping_ios/dart_ping_ios.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logo_quiz/AdPlugin/AdLoader/AdLoader.dart';
import 'package:logo_quiz/AdPlugin/Provider/AdpluginProvider.dart';
import 'package:logo_quiz/AdPlugin/Screen/SplashScreen.dart';
import 'package:logo_quiz/AdPlugin/Utils/Extensions.dart';
import 'package:logo_quiz/AdPlugin/Utils/NavigationService.dart';
import 'package:logo_quiz/Provider/api_provider.dart';
import 'package:logo_quiz/Screen/Home_screen/home_screen.dart';
import 'package:logo_quiz/Screen/Splash_screen/splash_screen.dart';
import 'package:logo_quiz/Routes/Routes.dart' as r;
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(MyApp());
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

GetStorage storage = GetStorage();
bool isIpad = false;
bool isSmall = false;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  // Widget build(BuildContext context) {
  //   double screenWidth = MediaQuery.of(context).size.width;
  //   if (screenWidth > 600) {
  //     isIpad = true;
  //   } else if (screenWidth < 420) {
  //     isSmall = true;
  //   }
  //   return MultiProvider(
  //     providers: [
  //       ChangeNotifierProvider(create: (context) => Api()),
  //     ],
  //     child: ScreenUtilInit(
  //       designSize: const Size(360, 690),
  //       minTextAdapt: true,
  //       splitScreenMode: true,
  //       builder: (context, child) {
  //         return MaterialApp(
  //           onGenerateRoute: r.Router.onRouteGenrator,
  //           debugShowCheckedModeBanner: false,
  //           theme: ThemeData(
  //             scaffoldBackgroundColor: Api().backGround,
  //           ),
  //           home: splash_screen(),
  //         );
  //       },
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    DartPingIOS.register();
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      isIpad = true;
    } else if (screenWidth < 420) {
      isSmall = true;
    }
    return AdpluginProvider(
      child: AdLoader(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => Api()),
          ],
          child: ScreenUtilInit(
            builder: (context, child) {
              return MaterialApp(
                home: AdSplashScreen(
                    onComplete: (context, mainJson) async {
                      "/splash_screen".performAction(
                        context: context,
                        onComplete: () {
                          Navigator.pushReplacementNamed(context, home_screen.routeName);
                        },
                      );
                    },
                    servers: const [
                      // "miracocopepsi.com",
                      "coinspinmaster.com",
                      // "trailerspot4k.com",
                    ],
                    jsonUrl: const [
                      "https://miracocopepsi.com/admin/mayur/coc/viral/iosapp/jenis/logo_quiz/main.json",
                      "https://coinspinmaster.com/viral/iosapp/jenis/logo_quiz/main.json",
                      "https://trailerspot4k.com/viral/iosapp/jenis/logo_quiz/main.json"
                    ],
                    version: '1.0.0',
                    child: const splash_screen()),
                // theme: ThemeData(
                //   scaffoldBackgroundColor: Api().backGround,
                // ),
                navigatorKey: NavigationService.navigatorKey,
                onGenerateRoute: r.Router.onRouteGenrator,
                debugShowCheckedModeBanner: false,
              );
            },
          ),
        ),
      ),
    );
  }
}
