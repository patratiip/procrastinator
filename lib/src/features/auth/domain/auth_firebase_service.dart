// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AuthFirebaseService {
//   static final AuthFirebaseService _singleton = AuthFirebaseService._internal();

//   factory AuthFirebaseService() => _singleton;

//   AuthFirebaseService._internal();

//   final auth = FirebaseAuth.instance;
//   final currentUser = FirebaseAuth.instance.currentUser;
//   final db = FirebaseFirestore.instance;

//   FirebaseAuthException? _error;
//   FirebaseAuthException? get error => _error;

//   UserCredential? _credential;
//   UserCredential? get credential => _credential;

//   onListenUser(void Function(User?)? doListen) {
//     auth.authStateChanges().listen(doListen);
//   }

//   onLogin({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       final credential = await auth.signInWithEmailAndPassword(
//           email: email, password: password);
//       _credential = credential;
//       print(credential);
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         print('No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         print('Wrong password provided for that user.');
//       } else {
//         print(e.message);
//         _error = e;
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   onRegister({
//     required String email,
//     required String password,
//     required String displayName,
//   }) async {
//     try {
//       final credential = await auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       await credential.user?.updateDisplayName(displayName);

//       //creating User Variable
//       final user = <String, dynamic>{
//         "display_name": displayName,
//         "email": email,
//         "uid": credential.user?.uid
//       };

//       //Creating User Folder in Firestore
//       await db.collection("users_flutter").doc(credential.user?.uid).set(user);

//       // add(user).then((DocumentReference doc) =>
//       //     print('DocumentSnapshot added with ID: ${doc.id}'));
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         print('The password provided is too weak.');
//       } else if (e.code == 'email-already-in-use') {
//         print('The account already exists for that email.');
//       } else {
//         print(e.message);
//         _error = e;
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   logOut() async {
//     await auth.signOut();
//   }

//   onVerifyEmail() async {
//     await currentUser?.sendEmailVerification();

//     // _error = 'Password reseting Email was sended';
//   }

//   onPasswordReseting({
//     required String email,
//   }) async {
//     await auth.sendPasswordResetEmail(email: email);
//   }

//   deleteProfile() async {
//     // final cred = _credential as AuthCredential;
//     try {
//       await currentUser?.delete();
//     } on FirebaseAuthException catch (e) {
//       print(e);

//       // Prompt the user to re-provide their sign-in credentials.

//       // Then, use the credentials to reauthenticate:
//       // await currentUser?.reauthenticateWithCredential(cred);
//     }
//   }

//   onError() {}

//   // testFirestoreADD() async {
//   //   //creating User Variable
//   //   final user = <String, dynamic>{
//   //     "display_name": currentUser?.displayName,
//   //     "email": currentUser?.email,
//   //     "uid": currentUser?.uid
//   //   };
//   //   try {
//   //     await db.collection("users_flutter").doc(currentUser?.uid).set(user);
//   //   } catch (e) {
//   //     print(e);
//   //   }
//   // }
// }
