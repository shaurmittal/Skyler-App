import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // header
              DrawerHeader(
                  child: Icon(
                Icons.favorite,
                color: Colors.grey[700],
              )),
              const SizedBox(
                height: 25,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("H O M E"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("P R O F I L E"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/profile_page');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text("A D D  E V E N T"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/event_page');
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25),
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("L O G O U T"),
              onTap: () {
                Navigator.pop(context);
                logout();
              },
            ),
          ),
        ], // children
      ),
    );
  }
}
