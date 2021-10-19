import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:email_auth/email_auth.dart';
import 'package:winlife_conselor_flutter/constant/color.dart';
import 'package:winlife_conselor_flutter/data/model/conselor_model.dart';
import 'package:winlife_conselor_flutter/data/model/user_model.dart';
import 'package:winlife_conselor_flutter/data/provider/FCM.dart';
import 'package:winlife_conselor_flutter/data/provider/http_service.dart';
import 'package:winlife_conselor_flutter/routes/app_routes.dart';
import 'package:winlife_conselor_flutter/screens/widget/dialog.dart';
import 'package:winlife_conselor_flutter/screens/widget/loader_dialog.dart';

class AuthController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  var selectIndexLang = 0.obs;

  final storage = GetStorage();
  final _user = Rx<UserData>(UserData.initial());
  UserData get user => _user.value;
  set user(UserData value) => _user.value = value;

  register(BuildContext context, String name, String email, String password,
      String mobileNumber, double strengt,
      {bool socialRegis = false}) async {
    if (name == '' || password == '' || mobileNumber == '' || email == '') {
      customDialog(context, "Oops!", 'Form tidak boleh kosong');
    } else if (!GetUtils.isEmail(email)) {
      customDialog(context, "Oops!", 'Format email salah');
    } else if (strengt < 0.3) {
      customDialog(context, "Oops!", 'Password lemah');
    } else if (!GetUtils.isNum(mobileNumber)) {
      customDialog(context, "Oops!", 'Nomor telepon tidak sesuai');
    } else {
      loaderDialog(
          context,
          SpinKitFadingCircle(
            color: mainColor,
          ),
          "Please Wait");
      var result =
          await HttpService.register(name, email, password, mobileNumber);

      Navigator.pop(Get.overlayContext!);
      if (result != null) {
        if (result['status']) {
          if (socialRegis) {
            Get.offAllNamed(Routes.MAIN);
          } else {
            Get.offNamed(Routes.OTP,
                arguments: {'email': email, 'password': password});
          }
        } else {
          customDialog(context, "Oops!", result['message']);
        }
      }
    }
  }

  Future<void> sendOtp(BuildContext context, String email) async {
    EmailAuth.sessionName = 'Winlife Verification';
    var res = await EmailAuth.sendOtp(receiverMail: email);
    if (!res) {
      customDialog(context, "Oops!", "Terjadi kesalahan");
    }
  }

  Future<void> verifyOTP(
      BuildContext context, String email, String password, String otp) async {
    // loaderDialog(
    //     context,
    //     SpinKitFadingCircle(
    //       color: mainColor,
    //     ),
    //     "Please Wait");
    login(context, email, password);
    // var res = EmailAuth.validate(receiverMail: email, userOTP: otp);

    // if (res) {
    //   Navigator.pop(Get.overlayContext!);
    //   login(context, email, password);
    // } else {
    //   customDialog(context, "Oops!", "Kode OTP tidak sesuai");
    // }
  }

  login(BuildContext context, String email, String password) async {
    loaderDialog(
        context,
        SpinKitFadingCircle(
          color: mainColor,
        ),
        "Please Wait");
    var result = await HttpService.login(email, password);
    if (result['status']) {
      user = UserData.fromJson(result['data'], result['token']);
      await storage.write('login', {'email': email, 'password': password});
      await socialSignIn(user.uid, user.fullName, user.email);
      var res = await HttpService.getAllConselor(user.token);
      List listConselor = res['data']['register_konselor'];
      var resConselor = listConselor
          .where((element) => element['email'] == user.email)
          .toList();
      if (resConselor.isEmpty) {
        Get.back();
        Get.defaultDialog(middleText: "Anda belum di approve");
      } else {
        var conselor = Conselor.fromJson(resConselor.single);

        user.conselorData = conselor;
        var detail = await HttpService.getConselor(user.token, conselor.id);
        print("detail");

        await storage.write('user', user);
        print(detail);
        if (detail != null) {
          conselor.conselorDetail = ConselorDetail.fromJson(detail);

          await storage.write('user', user);

          Get.offAllNamed(Routes.MAIN);
        } else {
          Get.toNamed(Routes.REGISTERFILE);
        }
      }
    } else {
      Navigator.pop(Get.overlayContext!);
      customDialog(context, "Oops!", result['message']);
    }
  }

  socialSignIn(String user, String name, String email) async {
    await FirebaseFirestore.instance.collection("conselors").doc(email).set({
      'nama': name,
      'email': email,
    }, SetOptions(merge: true));
  }

  refreshToken() async {
    var data = await storage.read('login');
    var userSt = await storage.read('user');
    var result = await HttpService.login(data['email'], data['password']);
    print("userSt");
    print(userSt);
    if (result['status']) {
      user = UserData.fromJson(result['data'], result['token']);
      await socialSignIn(user.uid, user.fullName, user.email);
      var res = await HttpService.getAllConselor(user.token);
      List listConselor = res['data']['register_konselor'];
      var resConselor = listConselor
          .where((element) => element['email'] == user.email)
          .toList();
      if (resConselor.isNotEmpty) {
        var conselor = Conselor.fromJson(resConselor.single);

        user.conselorData = conselor;
        var detail = await HttpService.getConselor(user.token, conselor.id);
        print("detail");

        await storage.write('user', user);
        print(detail);
        if (detail != null) {
          conselor.conselorDetail = ConselorDetail.fromJson(detail);

          await storage.write('user', user);
        }
      }
    }
  }

  signInWithGoogle(BuildContext context) async {
    final user = await HttpService.signIngWithGoogle();
    if (user == null) {
      return;
    }
    final userCollection =
        FirebaseFirestore.instance.collection("conselors").doc(user.user!.uid);
    final userDoc = await userCollection.get();
    if (userDoc.exists) {
      login(context, user.user!.email!, user.user!.uid);
    } else {
      Get.toNamed(Routes.REGISTERSOCIAL, arguments: {
        'name': user.user!.displayName!,
        'email': user.user!.email!,
        'key': user.user!.uid,
        'user': user.user!.uid
      });
      // register(context, user.user!.displayName!, user.user!.email!,
      //     user.user!.uid, "34", 0.5);
    }
  }

  signInWithFacebook(BuildContext context) async {
    final user = await HttpService.signInWithFacebook();
    if (user == null) {
      return;
    }
    final userCollection =
        FirebaseFirestore.instance.collection("conselors").doc(user.user!.uid);
    final userDoc = await userCollection.get();
    print([user.user!.displayName!, user.user!.email!, user.user!.uid]);
    if (userDoc.exists) {
      login(context, user.user!.email!, user.user!.uid);
    } else {
      Get.toNamed(Routes.REGISTERSOCIAL, arguments: {
        'name': user.user!.displayName!,
        'email': user.user!.email!,
        'key': user.user!.uid,
        'user': user.user!.uid
      });
      // register(context, user.user!.displayName!, user.user!.email!,
      //     user.user!.uid, "34", 0.5);
    }
  }

  logout() {
    storage.erase();
    Get.offAllNamed(Routes.LANDING);
  }
}
