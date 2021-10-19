import 'package:get/get.dart';
import 'package:winlife_conselor_flutter/bindings/main_binding.dart';
import 'package:winlife_conselor_flutter/bindings/quickblox_binding.dart';
import 'package:winlife_conselor_flutter/bindings/rtc_binding.dart';
import 'package:winlife_conselor_flutter/routes/app_routes.dart';
import 'package:winlife_conselor_flutter/screens/auth/landingpage.dart';
import 'package:winlife_conselor_flutter/screens/auth/loginpage.dart';
import 'package:winlife_conselor_flutter/screens/auth/lupapassword.dart';
import 'package:winlife_conselor_flutter/screens/auth/otppage.dart';
import 'package:winlife_conselor_flutter/screens/auth/registerSocialPage.dart';
import 'package:winlife_conselor_flutter/screens/auth/register_conselor_file.dart';
import 'package:winlife_conselor_flutter/screens/auth/registerpage.dart';
import 'package:winlife_conselor_flutter/screens/main/dashboard.dart';
import 'package:winlife_conselor_flutter/screens/main/service/booked_screen.dart';
import 'package:winlife_conselor_flutter/screens/main/service/summary_screen.dart';
import 'package:winlife_conselor_flutter/screens/main/service/type/call_screen.dart';
import 'package:winlife_conselor_flutter/screens/main/service/type/chat_screen.dart';
import 'package:winlife_conselor_flutter/screens/main/service/type/vidcall_screen.dart';
import 'package:winlife_conselor_flutter/screens/splashscreen.dart';
import 'package:winlife_conselor_flutter/screens/webview.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.INITIAL,
        page: () => SplashScreen(),
        transition: Transition.fadeIn),
    GetPage(name: Routes.LANDING, page: () => LandingPage()),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterPage(),
    ),
    GetPage(
      name: Routes.REGISTERFILE,
      page: () => RegisterConselorFile(),
    ),
    GetPage(
      name: Routes.REGISTERSOCIAL,
      page: () => RegisterSocialPage(),
    ),
    GetPage(
      name: Routes.OTP,
      page: () => OTPVerification(),
    ),
    GetPage(
      name: Routes.FORGETPASSWORD,
      page: () => LupaPasswordPage(),
    ),
    GetPage(
      name: Routes.CHANGEPASSWORD,
      page: () => LupaPasswordPage(),
    ),
    GetPage(
        name: Routes.MAIN,
        page: () => DashboardPage(),
        bindings: [MainBindings(), QBBindings()]),
    GetPage(name: Routes.WEBVIEW, page: () => WebViewPage()),
    GetPage(name: Routes.BOOKEDSCREEN, page: () => BookedScreen()),
    GetPage(name: Routes.CALLSCREEN, page: () => CallScreen()),
    GetPage(name: Routes.CHATSCREEN, page: () => ChatScreen()),
    GetPage(name: Routes.VIDCALLSCREEN, page: () => VidCallScreen()),
    GetPage(name: Routes.SUMMARYSCREEN, page: () => SummaryScreen()),
  ];
}
