import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'constants/color_constants.dart';
import 'constants/hive_constants.dart';
import 'firebase_options.dart';
import 'routes/app_pages.dart';
import 'utils/size/size_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  await Hive.openBox(isAuthHive);
  await Hive.openBox(userTypeHive);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Sociavism",
      initialRoute: getLoggedIn() ? Routes.HOME : Routes.SIGNUP,
      getPages: AppPages.routes,
      onInit: () => SizeConfig().init(context),
      theme: ThemeData(
        scaffoldBackgroundColor: ColorConstants.lightGreen,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
