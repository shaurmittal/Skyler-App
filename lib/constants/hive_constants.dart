import 'package:hive_flutter/hive_flutter.dart';

// hive box name
const String isAuthHive = "isAuthHive";

// hive key name
const String authHiveKey = "authKey";

setLoggedIn(bool value) async {
  var isLoggedBox = Hive.box(isAuthHive);
  isLoggedBox.put(authHiveKey, value);
}

bool getLoggedIn() {
  var isLoggedBox = Hive.box(isAuthHive);
  return isLoggedBox.get(authHiveKey) ?? false;
}
