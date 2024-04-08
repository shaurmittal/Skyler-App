import 'package:get/get.dart';

import '../elements/auth/bindings/auth_binding.dart';
import '../elements/auth/pages/signup_page.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    // GetPage(
    //   name: _Paths.SESSION,
    //   page: () => const ScreenHandlerView(),
    //   binding: ScreenHandlerBinding(),
    // ),
    // GetPage(
    //   name: _Paths.INTRO,
    //   page: () => IntroView(),
    //   binding: IntroBinding(),
    // ),
    // GetPage(
    //   name: _Paths.USER,
    //   page: () => UserView(),
    //   binding: UserHomeBinding(),
    // ),
    // GetPage(
    //   name: _Paths.ADMIN,
    //   page: () => AdminHomeView(),
    //   binding: AdminHomeBinding(),
    // ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => SignUpPage(),
      binding: AuthBinding(),
    ),
    // GetPage(
    //   name: _Paths.SIGNUP,
    //   page: () => SignUpView(),
    //   binding: SignupBinding(),
    // ),
  ];
}
