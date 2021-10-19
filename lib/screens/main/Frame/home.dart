import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:winlife_conselor_flutter/constant/color.dart';
import 'package:winlife_conselor_flutter/controller/auth_controller.dart';
import 'package:winlife_conselor_flutter/controller/main_controller.dart';
import 'package:winlife_conselor_flutter/setting/language.dart';

class FrameHome extends StatefulWidget {
  const FrameHome({Key? key}) : super(key: key);

  @override
  _FrameHomeState createState() => _FrameHomeState();
}

class _FrameHomeState extends State<FrameHome> {
  final MainController _mainController = Get.find();
  var storage = GetStorage();
  SolidController _controller = SolidController();
  AuthController _authController = Get.find();
  @override
  void initState() {
    super.initState();
  }

  List lang = [
    Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: mainColor, shape: BoxShape.circle),
      child: Text(
        'ID',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
      ),
    ),
    Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: mainColor, shape: BoxShape.circle),
      child: Text(
        'EN',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Container(
          padding: const EdgeInsets.all(15),
          child: Row(children: [
            Expanded(
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Colors.grey[200],
                  ),
                  height: 40,
                  child: InkWell(
                      onTap: () {},
                      child: Row(
                          children: <Widget>[
                            Container(
                              child: Icon(
                                Icons.search,
                                size: 20,
                                color: Colors.black,
                              ),
                              margin: const EdgeInsets.only(right: 10),
                            ),
                            Expanded(
                              child: Text(
                                "Find News".tr,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: 'Muli'),
                              ),
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center))),
            ),
            Container(
              child: Image.asset(
                "assets/icon_message.png",
                width: 30,
              ),
              margin: const EdgeInsets.only(left: 20),
            ),
            Container(
                margin: const EdgeInsets.only(left: 20),
                child: InkWell(
                    onTap: () {
                      Get.defaultDialog(
                          title: "pilih bahasa".tr,
                          content: Column(
                            children: [
                              SizedBox(
                                height: 12,
                              ),
                              ListTile(
                                onTap: () {
                                  _authController.selectIndexLang.value = 0;
                                  LanguageService.changeLocale('id');
                                  storage.write('lang', 'id');
                                  Get.back();
                                },
                                leading: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: mainColor, shape: BoxShape.circle),
                                  child: Text(
                                    'ID',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 12),
                                  ),
                                ),
                                title: Text("Indonesia"),
                                trailing: Obx(
                                  () => Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: _authController
                                                      .selectIndexLang.value ==
                                                  0
                                              ? mainColor
                                              : Colors.grey,
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        Icons.check,
                                        size: 12,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              ListTile(
                                onTap: () {
                                  _authController.selectIndexLang.value = 1;
                                  LanguageService.changeLocale('en');
                                  storage.write('lang', 'en');
                                  Get.back();
                                },
                                leading: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      shape: BoxShape.circle),
                                  child: Text(
                                    'EN',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 12),
                                  ),
                                ),
                                title: Text("English"),
                                trailing: Obx(
                                  () => Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: _authController
                                                      .selectIndexLang.value ==
                                                  1
                                              ? mainColor
                                              : Colors.grey,
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        Icons.check,
                                        size: 12,
                                        color: Colors.white,
                                      )),
                                ),
                              )
                            ],
                          ));
                    },
                    child: Obx(
                        () => lang[_authController.selectIndexLang.value]))),
          ]),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _mainController.getAllData,
        child: SingleChildScrollView(
          child: Container(
              child: Column(children: [
            //=================================================================================
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(7))),
              margin: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 15, right: 15),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.green[700],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(7),
                            topRight: Radius.circular(7))),
                    child: Text(
                      "welcome".tr,
                      style: TextStyle(
                          fontFamily: 'mulibold', color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    child: Row(children: [
                      Container(
                          child: Image.asset("assets/logo-white.png"),
                          margin: const EdgeInsets.only(right: 10)),
                      Expanded(child: Container(height: 1, color: Colors.white))
                    ]),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        bottom: 20, top: 5, left: 10, right: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(children: [
                              Container(
                                padding: const EdgeInsets.only(top: 5),
                                margin: const EdgeInsets.only(right: 5, top: 0),
                                child: Row(children: [
                                  Expanded(
                                    child: Center(
                                      child: Container(
                                        width: 40,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            border: Border.all(
                                                color: Colors.white)),
                                        child: Image.asset(
                                          "assets/icon_banner_reward.png",
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Container(
                                        width: 40,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            border: Border.all(
                                                color: Colors.white)),
                                        child: Image.asset(
                                          "assets/icon_banner_reward.png",
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Container(
                                        width: 40,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            border: Border.all(
                                                color: Colors.white)),
                                        child: Image.asset(
                                          "assets/icon_banner_voucher.png",
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                              Container(
                                child: Row(children: [
                                  Expanded(
                                    child: Center(
                                        child: Text('Account'.tr,
                                            style: TextStyle(
                                                fontFamily: 'muli',
                                                fontSize: 11,
                                                color: Colors.white))),
                                  ),
                                  Expanded(
                                    child: Center(
                                        child: Text('History'.tr,
                                            style: TextStyle(
                                                fontFamily: 'muli',
                                                fontSize: 11,
                                                color: Colors.white))),
                                  ),
                                  Expanded(
                                    child: Center(
                                        child: Text('Hadiahku'.tr,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'muli',
                                                fontSize: 11,
                                                color: Colors.white))),
                                  ),
                                ]),
                                margin: const EdgeInsets.only(right: 3, top: 5),
                              ),
                            ]),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 15, left: 10),
                            width: 1,
                            height: 50,
                            color: Colors.white,
                          ),
                          Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      "MyPoint".tr,
                                      style: TextStyle(
                                          fontFamily: 'neosansbold',
                                          color: Colors.white),
                                    ),
                                    margin: const EdgeInsets.only(
                                        left: 3, bottom: 5),
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 6, top: 6),
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            border: Border.all(
                                                color: Colors.white)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(width: 3),
                                            FittedBox(
                                              child: Row(
                                                children: [
                                                  Obx(() {
                                                    return Text(
                                                      _mainController
                                                          .point.value,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'neosansbold',
                                                          fontSize: 13),
                                                    );
                                                  }),
                                                  Text(
                                                    "Point".tr,
                                                    style: TextStyle(
                                                        fontFamily: 'mulilight',
                                                        fontSize: 11),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Icon(
                                              FontAwesomeIcons.caretRight,
                                              size: 16,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 35,
                                        padding: const EdgeInsets.all(0),
                                        decoration: BoxDecoration(),
                                        child: Image.asset(
                                          "assets/icon_banner_point.png",
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ))
                        ]),
                  )
                ],
              ),
            ),
            //==========================================================================
            activeSwitch(),
          ])),
        ),
      ),
    );
  }

  activeSwitch() {
    return Obx(() => Switch(
        value: _mainController.isActive.value,
        onChanged: (value) => _mainController.isActive.value = value));
  }
}
