import 'package:get/get.dart';

import '../elements/auth/bindings/auth_binding.dart';
import '../elements/auth/pages/user/signup_page.dart';
import '../elements/home/bindings/home_binding.dart';
import '../elements/home/pages/home_page.dart';
import '../elements/user/bindings/user_binding.dart';
import '../elements/user/pages/ngo_detail_page.dart';
import '../elements/user/pages/user_detail_page.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SIGNUP;

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
      name: _Paths.SIGNUP,
      page: () => SignUpPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.USERDETAILS,
      page: () => UserDetailPage(),
      binding: UserBinding(),
    ),
    GetPage(
      name: _Paths.NGOUSERDETAILS,
      page: () => NGODetailPage(),
      binding: UserBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
