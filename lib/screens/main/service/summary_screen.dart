import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:winlife_conselor_flutter/constant/color.dart';
import 'package:winlife_conselor_flutter/controller/main_controller.dart';
import 'package:winlife_conselor_flutter/routes/app_routes.dart';
import 'package:winlife_conselor_flutter/screens/widget/loader_dialog.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({Key? key}) : super(key: key);

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  MainController _mainController = Get.find();
  TextEditingController _summary = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _summary.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Container(
            child: Container(
              padding: const EdgeInsets.only(left: 25, top: 0, right: 25),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  child: Text(
                                "Summary Order!",
                                style: TextStyle(
                                    fontFamily: 'neosansbold', fontSize: 24),
                              )),

                              //================================================
                              Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: TextFormField(
                                    maxLines: 10,
                                    controller: _summary,
                                    decoration: InputDecoration(
                                      label: Text("Summary"),
                                      labelStyle: TextStyle(color: mainColor),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: mainColor),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: mainColor),
                                      ),
                                    ),
                                  )),
                              InkWell(
                                onTap: () async {
                                  Get.defaultDialog(
                                      title: "Peringatan!",
                                      middleText:
                                          "Apakah anda ingin melanjutkan?",
                                      textConfirm: "Ya",
                                      textCancel: "Tidak",
                                      onCancel: null,
                                      onConfirm: () async {
                                        Get.back();
                                        if (_summary.text != "") {
                                          loaderDialog(
                                              context,
                                              SpinKitFadingCircle(
                                                  color: mainColor),
                                              "Please wait");
                                          await _mainController
                                              .addSummary(_summary.text);
                                          Get.until((route) =>
                                              Get.currentRoute == Routes.MAIN);
                                        } else {
                                          Get.defaultDialog(
                                              title: "Oops!",
                                              middleText: "Lengkapi Form");
                                        }
                                      },
                                      confirmTextColor: Colors.white,
                                      barrierDismissible: false);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 0.8,
                                          blurRadius: 5,
                                          offset: Offset(2,
                                              5), // changes position of shadow
                                        ),
                                      ],
                                      color: mainColor,
                                      border: Border.all(
                                        color: mainColor,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  padding: const EdgeInsets.all(13),
                                  margin: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Simpan",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'neosansbold',
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
