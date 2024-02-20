import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_drawer.dart';

class HomePageVol extends StatefulWidget {
  const HomePageVol({super.key});

  @override
  State<HomePageVol> createState() => _HomePageVolState();
}

class _HomePageVolState extends State<HomePageVol> {
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
        drawer: MyDrawer(),
      ),
    );
  }
}
