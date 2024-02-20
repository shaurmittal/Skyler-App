import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:main_sociavism/in_app%20pages/event_page.dart';
import 'package:main_sociavism/in_app%20pages/profile_page.dart';
import 'package:main_sociavism/pages/auth_page.dart';
import 'package:main_sociavism/pages/edit_profile_page.dart';
import 'package:main_sociavism/pages/home_pag.dart';
import 'package:main_sociavism/pages/login_or_register_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      routes: {
        '/login_register_page': (context) => const LoginOrRegisterPage(),
        '/home_pag': (context) => const HomePage(),
        '/profile_page': (context) => ProfilePage(),
        '/event_page': (context) => const EventPage(),
        '/edit_profile_page': (context) => const EditProfile(),
      },
    );
  }
}
