import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:winlife_conselor_flutter/constant/color.dart';
import 'package:winlife_conselor_flutter/controller/auth_controller.dart';
import 'package:winlife_conselor_flutter/data/provider/http_service.dart';
import 'package:winlife_conselor_flutter/routes/app_routes.dart';
import 'package:winlife_conselor_flutter/screens/widget/loader_dialog.dart';

class RegisterConselorFile extends StatefulWidget {
  const RegisterConselorFile({Key? key}) : super(key: key);

  @override
  _RegisterConselorFileState createState() => _RegisterConselorFileState();
}

class _RegisterConselorFileState extends State<RegisterConselorFile> {
  FilePickerResult? fotoConselor;
  FilePickerResult? suratRekomendasi;
  FilePickerResult? sertifikasi;

  AuthController _authController = Get.find();

  TextEditingController riwayatPendidikan = TextEditingController();
  TextEditingController lamaPengalaman = TextEditingController();
  TextEditingController riwayatPengalaman = TextEditingController();
  TextEditingController asosiasi = TextEditingController();
  StreamSubscription? download;

  RxDouble progress = RxDouble(0);

  @override
  void dispose() {
    // TODO: implement dispose
    riwayatPendidikan.dispose();
    lamaPengalaman.dispose();
    riwayatPengalaman.dispose();
    asosiasi.dispose();
    if (download != null) {
      download!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ls = MediaQuery.of(context).devicePixelRatio;
    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
              child: Container(
            padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
            child: Column(
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.only(top: 40, bottom: 20),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150,
                          child: new Image.asset("assets/logo-ls.png"),
                        ),
                      ],
                    )),
                Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    width: double.infinity,
                    child: Text(
                      "Complete your Registration",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontFamily: "NeoSansBold", fontSize: 18),
                    )),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.only(left: 5, right: 10),
                    width: double.infinity,
                    child: Text(
                      "Riwayat Pendidikan ",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontFamily: "mulilight", fontSize: 12),
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.only(left: 5, right: 10),
                  width: double.infinity,
                  child: TextFormField(
                    autofocus: false,
                    controller: riwayatPendidikan,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: '1. SMA Merdeka Mandiri - 2020',
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.only(left: 5, right: 10),
                    width: double.infinity,
                    child: Text(
                      "Lama Pengalaman",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontFamily: "mulilight", fontSize: 12),
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.only(left: 5, right: 10),
                  width: double.infinity,
                  child: TextFormField(
                    autofocus: false,
                    controller: lamaPengalaman,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: '1', suffixText: "Tahun"),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.only(left: 5, right: 10),
                    width: double.infinity,
                    child: Text(
                      "Riwayat Pengalaman",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontFamily: "mulilight", fontSize: 12),
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.only(left: 5, right: 10),
                  width: double.infinity,
                  child: TextFormField(
                    autofocus: false,
                    controller: riwayatPengalaman,
                    decoration: const InputDecoration(
                      hintText: '',
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.only(left: 5, right: 10),
                    width: double.infinity,
                    child: Text(
                      "Asosiasi Conselor ",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontFamily: "mulilight", fontSize: 12),
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.only(left: 5, right: 10),
                  width: double.infinity,
                  child: TextFormField(
                    autofocus: false,
                    controller: asosiasi,
                    decoration: const InputDecoration(
                      hintText: 'Optional',
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.only(left: 5, right: 10),
                    width: double.infinity,
                    child: Text(
                      "Sertifikasi ",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontFamily: "mulilight", fontSize: 12),
                    )),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: 200,
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: InkWell(
                          onTap: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();
                            if (result != null) {
                              setState(() {
                                sertifikasi = result;
                              });
                            }
                          },
                          child: Center(
                              child: sertifikasi != null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.document_scanner),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(sertifikasi!.files.single.name),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                sertifikasi = null;
                                              });
                                            },
                                            child: Text("Delete"))
                                      ],
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.file_upload_rounded),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text("Upload Your Document")
                                      ],
                                    )),
                        ),
                      ),
                    )),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.only(left: 5, right: 10),
                    width: double.infinity,
                    child: Text(
                      "Foto Conselor ",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontFamily: "mulilight", fontSize: 12),
                    )),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: 200,
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: InkWell(
                          onTap: () async {
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles(type: FileType.image);
                            if (result != null) {
                              setState(() {
                                fotoConselor = result;
                              });
                            }
                          },
                          child: Center(
                              child: fotoConselor != null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 120,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black)),
                                          child: Image.file(
                                            File(fotoConselor!
                                                .files.single.path!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                fotoConselor = null;
                                              });
                                            },
                                            child: Text("Delete"))
                                      ],
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.file_upload_rounded),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text("Upload Your Document")
                                      ],
                                    )),
                        ),
                      ),
                    )),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.only(left: 5, right: 10),
                    width: double.infinity,
                    child: Text(
                      "Surat Rekomendasi ",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontFamily: "mulilight", fontSize: 12),
                    )),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: 200,
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: InkWell(
                          onTap: () async {
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles(type: FileType.any);
                            if (result != null) {
                              setState(() {
                                suratRekomendasi = result;
                              });
                            }
                          },
                          child: Center(
                            child: suratRekomendasi != null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.document_scanner),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(suratRekomendasi!.files.single.name),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              suratRekomendasi = null;
                                            });
                                          },
                                          child: Text("Delete"))
                                    ],
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.file_upload_rounded),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text("Upload Your Document")
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    )),
                Center(
                  child: InkWell(
                    onTap: () async {
                      if (fotoConselor != null &&
                          sertifikasi != null &&
                          suratRekomendasi != null &&
                          riwayatPendidikan.text != "" &&
                          lamaPengalaman.text != "" &&
                          riwayatPengalaman.text != "" &&
                          riwayatPengalaman.text != "") {
                        if (asosiasi.text == "") {
                          asosiasi.text = "-";
                        }
                        loaderDialog(
                            context,
                            SpinKitFadingCircle(
                              color: mainColor,
                            ),
                            "Please Wait");
                        var res = await HttpService.registerBerkas(
                            fotoConselor!.files.single.path!,
                            suratRekomendasi!.files.single.path!,
                            sertifikasi!.files.single.path!,
                            _authController.user.conselorData!.id,
                            _authController.user.token,
                            riwayatPendidikan.text,
                            lamaPengalaman.text,
                            riwayatPengalaman.text,
                            asosiasi.text);
                        if (res != null) {
                          download = res.stream.listen((value) async {
                            if (res.statusCode == 200) {
                              Get.offAllNamed(Routes.MAIN);
                            }
                            print(value.length);
                          });
                        } else {
                          Get.defaultDialog(
                              title: "Oops!", middleText: "Upload Gagal");
                        }
                      } else {
                        Get.defaultDialog(
                            title: "Oops!", middleText: "Lengkapi Form");
                      }
                    },
                    child: Container(
                        width: double.infinity,
                        height: 45,
                        margin: const EdgeInsets.only(top: 30),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.0),
                          child: Material(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(5),
                            shadowColor: mainColor,
                            elevation: 5.0,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              elevation: 0.0,
                              minWidth: 200.0,
                              height: 50.0,
                              onPressed: null,
                              color: mainColor,
                              child: Text('CONTINUE',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontFamily: 'mulibold')),
                            ),
                          ),
                        )),
                  ),
                ),
                Center(
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    margin: const EdgeInsets.only(top: 10, bottom: 5),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          Get.offAllNamed(Routes.LANDING);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an Account? ',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                  fontFamily: 'muli'),
                            ),
                            Text(
                              'Login Here',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: mainColor,
                                  fontFamily: 'mulibold'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ))),
    );
  }

  Widget uploadFile() {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.only(left: 10, right: 10),
        height: 200,
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: InkWell(
              onTap: () {},
              child: Center(
                child: Image.network(
                    "https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832__480.jpg"),
              ),
            ),
          ),
        ));
  }

  Future<bool> _onBackPress() async {
    return true;
  }
}
