import 'package:hive_flutter/hive_flutter.dart';

// hive box name
const String isAuthHive = "isAuthHive";
const String userTypeHive = "userTypeHive";

// hive key name
const String authHiveKey = "authKey";
const String userTypeHiveKey = "userTypeKey";

setLoggedIn(bool value) async {
  var isLoggedBox = Hive.box(isAuthHive);
  isLoggedBox.put(authHiveKey, value);
}

bool getLoggedIn() {
  var isLoggedBox = Hive.box(isAuthHive);
  return isLoggedBox.get(authHiveKey) ?? false;
}

// USER, NGO, ADMIN
setUserType(String value) async {
  var userTypeBox = Hive.box(userTypeHive);
  userTypeBox.put(userTypeHiveKey, value);
}

String getUserType() {
  var userTypeBox = Hive.box(userTypeHive);
  return userTypeBox.get(userTypeHiveKey);
}

enum UserType {
  USER,
  NGO,
  ADMIN,
}
