import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logger/logger.dart';

import '../base_auth_user_provider.dart';

export '../base_auth_user_provider.dart';

final _logger = Logger();

class EssenYemekFirebaseUser extends BaseAuthUser {
  EssenYemekFirebaseUser(this.user);
  User? user;
  @override
  bool get loggedIn => user != null;

  @override
  AuthUserInfo get authUserInfo => AuthUserInfo(
        uid: user?.uid,
        email: user?.email,
        displayName: user?.displayName,
        photoUrl: user?.photoURL,
        phoneNumber: user?.phoneNumber,
      );

  @override
  Future? delete() => user?.delete();

  @override
  Future? updateEmail(String email) async {
    await user?.verifyBeforeUpdateEmail(email);
  }

  @override
  Future? updatePassword(String newPassword) async {
    await user?.updatePassword(newPassword);
  }

  @override
  Future? sendEmailVerification() => user?.sendEmailVerification();

  @override
  bool get emailVerified {
    // Reloads the user when checking in order to get the most up to date
    // email verified status.
    if (loggedIn && !user!.emailVerified) {
      refreshUser();
    }
    return user?.emailVerified ?? false;
  }

  @override
  Future refreshUser() async {
    await FirebaseAuth.instance.currentUser
        ?.reload()
        .then((_) => user = FirebaseAuth.instance.currentUser);
  }

  static BaseAuthUser fromUserCredential(UserCredential userCredential) =>
      fromFirebaseUser(userCredential.user);
  static BaseAuthUser fromFirebaseUser(User? user) =>
      EssenYemekFirebaseUser(user);
}

Stream<BaseAuthUser> essenYemekFirebaseUserStream() {
  try {
    return FirebaseAuth.instance
        .authStateChanges()
        .handleError((error) {
          _logger.e('Firebase Auth stream error: $error');
          // Return null user on error - user is logged out
        })
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<BaseAuthUser>(
          (user) {
            currentUser = EssenYemekFirebaseUser(user);
            return currentUser!;
          },
        );
  } catch (e) {
    _logger.e('Failed to create auth stream: $e');
    // Return empty stream with logged out user
    currentUser = EssenYemekFirebaseUser(null);
    return Stream.value(currentUser!);
  }
}
