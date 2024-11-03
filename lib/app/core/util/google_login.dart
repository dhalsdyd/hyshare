import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hyshare/app/widgets/snackbar.dart';

class GoogleSignHelper {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email", "profile"]);

  Future<UserCredential?> authenticate({bool selectAccount = true}) async {
    if (selectAccount && _googleSignIn.currentUser != null) {
      try {
        if (kIsWeb) {
          await _googleSignIn.signOut();
        }

        if (Platform.isAndroid) {
          await _googleSignIn.signOut();
        } else {
          await _googleSignIn.disconnect();
        }
      } catch (e) {
        await _googleSignIn.disconnect();
      }
    }

    if (kIsWeb) {
      await _googleSignIn.canAccessScopes(["email", "profile"]);
    }

    final GoogleSignInAccount? googleAccount =
        !kIsWeb ? await _googleSignIn.signIn() : await _googleSignIn.signInSilently(suppressErrors: false, reAuthenticate: true);

    if (googleAccount == null) {
      return null;
    }

    if (!googleAccount.email.contains("hanyang.ac.kr")) {
      FGBPSnackBar.open("한양대학교 이메일로 로그인해주세요.");
      return null;
    }

    final GoogleSignInAuthentication googleAuth = await googleAccount.authentication;

    UserCredential credential = await FirebaseAuth.instance.signInWithCredential(GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    ));

    return credential;
  }
}
