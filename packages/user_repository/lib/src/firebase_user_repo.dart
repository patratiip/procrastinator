import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:rxdart/rxdart.dart';
import 'package:user_repository/user_repository.dart';

class FirebaseUserRepository implements IUserRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final _usersCollection =
      FirebaseFirestore.instance.collection('users_flutter');

  FirebaseUserRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  // @override
  // Stream<MyUser> get user {
  //   return _firebaseAuth.authStateChanges().flatMap((firebaseUser) async* {
  //     if (firebaseUser == null) {
  //       yield MyUser.empty;
  //     } else {
  //       yield await _usersCollection.doc(firebaseUser.uid).get().then((value) =>
  //           MyUser.fromEntity(MyUserEntity.fromDocument(value.data()!)));
  //     }
  //   });
  // }

  // @override
  // Stream<MyUser> get userCollection {
  //   if (_firebaseAuth.currentUser == null) {
  //     return user;
  //   } else {
  //     return _usersCollection
  //         .doc(_firebaseAuth.currentUser!.uid)
  //         .snapshots()
  //         .map((userCol) =>
  //             MyUser.fromEntity(MyUserEntity.fromDocument(userCol.data()!)));
  //   }
  // }
  @override
  Stream<MyUser> get user {
    return _firebaseAuth.authStateChanges().switchMap((firebaseUser) {
      if (firebaseUser == null) {
        return Stream.value(MyUser.empty);
      } else {
        return _usersCollection
            .doc(firebaseUser.uid)
            .snapshots()
            .map((snapshot) {
          final data = snapshot.data();
          if (data != null) {
            return MyUser.fromEntity(MyUserEntity.fromDocument(data));
          } else {
            log('message');
            return MyUser.empty;
          }
        });
      }
    });
  }

  @override
  MyUser get currentUser {
    return _firebaseAuth.currentUser?.toUser ?? MyUser.empty;
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on firebase_auth.FirebaseAuthException catch (e) {
      log(e.code);
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      firebase_auth.UserCredential user =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: myUser.email, password: password);
      log('Sign Up user -- ${user.toString()}');
      myUser = myUser.copyWith(userId: user.user!.uid);
      log('Sign Up -- ${myUser.toString()}');
      return myUser;
    } on firebase_auth.FirebaseAuthException catch (e) {
      log(e.code);
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }

  @override
  Future<void> setUserData(MyUser myUser) async {
    try {
      await _usersCollection
          .doc(myUser.userId)
          .set(myUser.toEntity().toDocument());
    } catch (e) {
      log('SET -- ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> onPasswordReseting({
    required String email,
  }) async {
    //TODO Exceptions!!!
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> onVerifyEmail() async {
    //TODO Exceptions!!!
    await _firebaseAuth.currentUser!.sendEmailVerification();
  }

  // deleteProfile() async {
  //   //TODO Exceptions!!!
  //   try {
  //     await _firebaseAuth.currentUser!.delete();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  /// Add [Group] to User collection
  Future<void> addGroupToUserCollection(String groupID) async {
    try {
      await _usersCollection.doc(currentUser.userId).update({
        'group': FirebaseFirestore.instance.doc('group_flutter/$groupID'),
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

extension on firebase_auth.User {
  /// Maps a [firebase_auth.User] into a [MyUser].
  MyUser get toUser {
    return MyUser(
      userId: uid,
      email: email!,
      userType: UserType.initial,
      name: displayName,
      photoURL: photoURL,
      schoolGeoPosition: const SchoolGeoPosition(latitude: 0, longitude: 0),
    );
  }
}

// /////////////////////////EXCEPTIONS/////////////////////////

//EXAMPLE
// ///// Signs in with the provided [email] and [password].
//   ///
//   /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
//   Future<void> logInWithEmailAndPassword({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       await _firebaseAuth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//     } on firebase_auth.FirebaseAuthException catch (e) {
//       throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
//     } catch (_) {
//       throw const LogInWithEmailAndPasswordFailure();
//     }
//   }

class SignUpWithEmailAndPasswordFailure implements Exception {
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// Thrown during the login process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailAndPassword.html

class LogInWithEmailAndPasswordFailure implements Exception {
  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// Thrown during the sign in with google process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithCredential.html

class LogInWithGoogleFailure implements Exception {
  const LogInWithGoogleFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleFailure(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const LogInWithGoogleFailure(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const LogInWithGoogleFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const LogInWithGoogleFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithGoogleFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithGoogleFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const LogInWithGoogleFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleFailure(
          'The credential verification ID received is invalid.',
        );
      default:
        return const LogInWithGoogleFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}
