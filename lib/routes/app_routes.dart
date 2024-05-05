part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SESSION = _Paths.SESSION;
  static const ONBOARD = _Paths.ONBOARD;
  static const LOGIN = _Paths.LOGIN;
  static const SIGNUP = _Paths.SIGNUP;
  static const NGOSIGNUP = _Paths.NGOSIGNUP;
  static const NGOLOGIN = _Paths.NGOLOGIN;
  static const USERDETAILS = _Paths.USERDETAILS;
  static const NGOUSERDETAILS = _Paths.NGOUSERDETAILS;
  static const HOME = _Paths.HOME;
  static const ADMIN = _Paths.ADMIN;
  static const USER = _Paths.USER;
  static const NGO = _Paths.NGO;
}

abstract class _Paths {
  _Paths._();
  static const SESSION = '/session';
  static const ONBOARD = '/onboard';
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const NGOSIGNUP = '/ngo_signup';
  static const NGOLOGIN = '/ngo_login';
  static const USERDETAILS = '/userdetails';
  static const NGOUSERDETAILS = '/ngo_userdetails';
  static const HOME = '/home';

  static const ADMIN = '/admin';
  static const USER = '/user';
  static const NGO = '/ngo';
}
