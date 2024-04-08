part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SESSION = _Paths.SESSION;
  static const ONBOARD = _Paths.ONBOARD;
  static const LOGIN = _Paths.LOGIN;
  static const SIGNUP = _Paths.SIGNUP;
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

  static const ADMIN = '/admin';
  static const USER = '/user';
  static const NGO = '/ngo';
}
