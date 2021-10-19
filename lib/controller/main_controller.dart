import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:winlife_conselor_flutter/constant/request_permission.dart';
import 'package:winlife_conselor_flutter/controller/auth_controller.dart';
import 'package:winlife_conselor_flutter/data/provider/FCM.dart';
import 'package:winlife_conselor_flutter/data/provider/http_service.dart';

class MainController extends GetxController {
  final AuthController _authController = Get.find();

  var isActive = false.obs;
  var paid = false.obs;
  var point = "0".obs;
  var historyLoad = false.obs;

  late StreamSubscription<String> tokenFCMsub;
  late StreamSubscription<bool> isActiveSub;
  CollectionReference _conselorFirestore =
      FirebaseFirestore.instance.collection('conselors');
  Stream<DateTime> date = Stream.periodic(Duration(seconds: 1), (i) {
    return DateTime.now();
  });

  fcmInit() async {
    String? token = await FCM.messaging.getToken();
    await FCM.saveTokenToDatabase(token!, _authController.user.email);
    tokenFCMsub = FCM.messaging.onTokenRefresh.listen((event) {
      FCM.saveTokenToDatabase(event, _authController.user.email);
    });
  }

  inOrder(bool order) async {
    await _conselorFirestore
        .doc(_authController.user.email)
        .set({'inOrder': order}, SetOptions(merge: true));
  }

  subscribeIsActive() {
    isActiveSub = isActive.listen((val) {
      _conselorFirestore
          .doc(_authController.user.email)
          .set({'isActive': val}, SetOptions(merge: true));
    });
  }

  addSummary(String summary) async {
    var res = await HttpService.addSummary(_authController.user.token, summary);
    print(res);
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await fcmInit();
    subscribeIsActive();
  }

  Future<void> getAllData() async {}

  @override
  void onClose() {
    // TODO: implement onClose
    isActive.value = false;
    tokenFCMsub.cancel();
    isActiveSub.cancel();
    super.onClose();
  }
}
