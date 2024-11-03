import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hyshare/app/core/util/permission.dart';
import 'package:hyshare/app/data/models/user.dart' as app;

class AuthService extends GetxService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final Rx<UserCredential?> _tempToken = Rx(null);
  final Rx<String?> _accessToken = Rx(null);
  final Rx<String?> _fcmToken = Rx(null);
  final Rx<app.User?> user = Rx(null);

  /// google sign-in과 onboarding 과정이 완료되었을 경우 true
  bool get isAuthenticated => _accessToken.value != null;

  String? get accessToken => _accessToken.value;
  String? get fcmToken => _fcmToken.value;

  Future<AuthService> init() async {
    _accessToken.value = await _storage.read(key: 'accessToken');
    _fcmToken.value = await _storage.read(key: 'fcmToken');
    if (_accessToken.value != null) {
      _firebaseFirestore.collection('users').doc(_accessToken.value).snapshots().listen((event) {
        user.value = app.User.fromJson(event.data()!);
      });
    }

    return this;
  }

  Future<void> _setAccessToken(String token) async {
    await _storage.write(key: 'accessToken', value: token);
    _accessToken.value = token;
  }

  Future<void> _setFcmToken(String token) async {
    _fcmToken.value = token;
    log('fcmToken: $token');
    await _storage.write(key: 'fcmToken', value: token);
  }

  Future<bool?> checkOnboarding(tempToken) async {
    _tempToken.value = tempToken;
    if (_tempToken.value == null) {
      return null;
    }
    String uid = _tempToken.value!.user!.uid;
    final DocumentSnapshot<Map<String, dynamic>> user = await _firebaseFirestore.collection('users').doc(uid).get();
    if (!user.exists) {
      return false;
    }

    return true;
  }

  Future<void> getFcmToken() async {
    bool isGranted = await PermissionHelper().requestNotification2();
    if (!isGranted) {
      return;
    }

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.getToken().then((value) => _setFcmToken(value ?? ""));
  }

  Future<void> removeFcmToken() async {
    await _storage.delete(key: 'fcmToken');
    _fcmToken.value = null;
  }

  Future<void> registerUser(String name, String account) async {
    try {
      log('registerUser');

      app.User user = app.User(
          userId: _tempToken.value!.user!.uid,
          rideId: "",
          name: _tempToken.value!.user!.displayName!,
          nickname: name,
          photoUrl: _tempToken.value!.user!.photoURL!,
          email: _tempToken.value!.user!.email!,
          phoneNumber: _tempToken.value!.user!.phoneNumber ?? "",
          paymentInfo: account,
          warningCount: 0,
          status: app.UserStatus.defaultStatus,
          fcmTokens: []);

      await _firebaseFirestore.collection('users').doc(user.userId).set(user.toJson());
      await _setAccessToken(_tempToken.value!.user!.uid);
      _tempToken.value = null;

      await getFcmToken();

      if (_accessToken.value != null) {
        _firebaseFirestore.collection('users').doc(_accessToken.value).snapshots().listen((event) {
          this.user.value = app.User.fromJson(event.data()!);
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> login() async {
    try {
      await _setAccessToken(_tempToken.value!.user!.uid);
      _tempToken.value = null;

      if (_fcmToken.value == null || _fcmToken.value!.isEmpty) {
        await getFcmToken();
      }

      if (_accessToken.value != null) {
        _firebaseFirestore.collection('users').doc(_accessToken.value).snapshots().listen((event) {
          log(event.data().toString());
          user.value = app.User.fromJson(event.data()!);
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    _accessToken.value = null;
    await _storage.delete(key: 'accessToken');
    await FirebaseAuth.instance.signOut();
    try {
      await _firebaseFirestore.collection('users').doc(_accessToken.value).update({
        'fcmTokens': FieldValue.arrayRemove([_fcmToken.value])
      });
    } catch (_) {}
  }
}
