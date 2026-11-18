import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // register
  Future<void> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await credential.user?.updateDisplayName(fullName);
  }

  // login
  Future<void> login({required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // forgot password
  Future<void> sendResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // sign out
  Future<void> logout() async {
    await _auth.signOut();
  }
}

String authErrorMessage(FirebaseAuthException e) {
  switch (e.code) {
    case 'email-already-in-use':
      return 'هذا البريد الإلكتروني مسجل بالفعل';
    case 'invalid-email':
      return 'البريد الإلكتروني غير صحيح';
    case 'weak-password':
      return 'كلمة المرور ضعيفة (6 أحرف على الأقل)';
    case 'user-not-found':
    case 'wrong-password':
    case 'invalid-credential':
      return 'البريد الإلكتروني أو كلمة المرور غير صحيحة';
    case 'too-many-requests':
      return 'محاولات كثيرة، حاول لاحقاً';
    case 'network-request-failed':
      return 'تحقق من اتصالك بالإنترنت';
    default:
      return 'حدث خطأ، حاول مرة أخرى';
  }
}
