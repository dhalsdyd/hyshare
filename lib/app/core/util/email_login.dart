import 'package:firebase_auth/firebase_auth.dart';

class EmailLoginHelper {
  Future<void> signInWithVerifyEmailAndPassword(String email) async {
    try {
      if (email.isEmpty || !email.contains("@hanyang.ac.kr")) {
        return;
      }
      UserCredential _credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: "password");
      await _credential.user!.sendEmailVerification();

      if (_credential.user != null) {
        // emailVerified : false
      }
    } on FirebaseAuthException catch (error) {
      String? _errorCode;
      switch (error.code) {
        case "email-already-in-use":
          _errorCode = error.code;
          break;
        case "invalid-email":
          _errorCode = error.code;
          break;
        case "weak-password":
          _errorCode = error.code;
          break;
        case "operation-not-allowed":
          _errorCode = error.code;
          break;
        default:
          _errorCode = null;
      }
    }
  }
}
