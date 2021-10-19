import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:winlife_conselor_flutter/data/provider/api.dart';

class HttpService {
  static GetStorage storage = GetStorage();
  //AUTH =======================================================================
  static Future<dynamic> register(
      String name, String email, String password, String mobileNumber) async {
    try {
      String url = Api.REGISTER;

      final res = await http.post(Uri.parse(url), body: {
        "email": email,
        "password": password,
        "mobile_number": mobileNumber,
        "name": name
      }, headers: {
        "x-api-key": Api.API_KEY,
      });
      final result = await compute(convert.jsonDecode, res.body);
      return result;
    } catch (e) {
      return null;
    }
  }

  static Future<http.StreamedResponse?> registerBerkas(
      String fotoConselor,
      String suratRekomendasi,
      String sertifikasi,
      String conselor_id,
      String token,
      String riwayatPendidikan,
      String lamaPengalaman,
      String riwayat_pengalaman,
      String asosiasi_konselor) async {
    try {
      String url = Api.KONSELORBERKAS;

      final request = new http.MultipartRequest("POST", Uri.parse(url));
      //add your fields here
      request.headers.addAll({"x-api-key": Api.API_KEY, "x-token": token});
      request.fields.addAll({
        'conselor_id': conselor_id,
        'riwayat_pendidikan': riwayatPendidikan,
        'riwayat_pengalaman': riwayat_pengalaman,
        'lama_pengalaman': lamaPengalaman,
        'asosiasi_konselor': asosiasi_konselor,
      });
      request.files
          .add(await http.MultipartFile.fromPath('sertifikasi', sertifikasi));

      request.files.add(
          await http.MultipartFile.fromPath('foto_konselor', fotoConselor));

      request.files.add(await http.MultipartFile.fromPath(
          'surat_rekomendasi', suratRekomendasi));
      var res = await request.send();
      return res;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<dynamic> login(String email, String password) async {
    String url = Api.LOGIN;

    final res = await http.post(Uri.parse(url), body: {
      "username": email,
      "password": password,
    }, headers: {
      "x-api-key": Api.API_KEY,
    });
    final result = await compute(convert.jsonDecode, res.body);
    print(result);
    return result;
  }

  static Future<dynamic> getAllConselor(String token) async {
    try {
      String url = Api.KONSELOR;

      final res = await http.get(Uri.parse(url),
          headers: {"x-api-key": Api.API_KEY, "x-token": token});
      final result = await compute(convert.jsonDecode, res.body);
      return result;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> getConselor(String token, String id) async {
    try {
      String url = Api.KONSELORDETAIL + "/?id=$id";

      final res = await http.get(Uri.parse(url),
          headers: {"x-api-key": Api.API_KEY, "x-token": token});
      final result = await compute(convert.jsonDecode, res.body);
      return result['data']['konselor_detail'].single;
    } catch (e) {
      return null;
    }
  }

  static Future<UserCredential?> signIngWithGoogle() async {
    final GoogleSignIn googleSignIn = new GoogleSignIn();

    GoogleSignInAccount? googleuser =
        await GoogleSignIn(scopes: <String>['email']).signIn();
    if (googleuser == null) {
      return null;
    }
    GoogleSignInAuthentication googleAuth = await googleuser.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    var user = await FirebaseAuth.instance.signInWithCredential(credential);
    googleSignIn.disconnect();
    return user;
  }

  static Future<UserCredential?> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance
        .login(permissions: ["email", "public_profile", "user_friends"]);
    // Create a credential from the access token
    print(loginResult.message);
    if (loginResult.status == LoginStatus.success) {
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    }
    return null;
  }

  //HOME =======================================================================

  static Future<dynamic> getAllKategori(String token) async {
    try {
      String url = Api.KATEGORI;

      final res = await http.get(Uri.parse(url),
          headers: {"x-api-key": Api.API_KEY, "x-token": token});
      final result = await compute(convert.jsonDecode, res.body);
      return result;
    } catch (e) {
      return null;
    }
  }

  //ORDER ======================================================================
  static Future<dynamic> getOrderDetail(String token) async {
    var sesi = storage.read('sesi');
    try {
      String url = Api.ORDERDETAIL + '?sesi=$sesi';

      final res = await http.get(Uri.parse(url),
          headers: {"x-api-key": Api.API_KEY, "x-token": token});
      final result = await compute(convert.jsonDecode, res.body);
      return result;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> addSummary(String token, String summary) async {
    var sesi = storage.read('sesi');
    try {
      String url = Api.ORDERDETAILSUMMARY;

      final res = await http.post(Uri.parse(url),
          headers: {"x-api-key": Api.API_KEY, "x-token": token},
          body: {'sesi': sesi, 'summary': summary});
      final result = await compute(convert.jsonDecode, res.body);
      return result;
    } catch (e) {
      return null;
    }
  }
}
