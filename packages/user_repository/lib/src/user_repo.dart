import 'models/models.dart';

abstract class UserRepository {
  Stream<MyUser> get user;
  Stream<MyUser> get userCollection;

  MyUser get currentUser;

  Future<MyUser> signUp(MyUser myUser, String password);

  Future<void> setUserData(MyUser user);

  Future<void> signIn(String email, String password);

  Future<void> onPasswordReseting({required String email});

  Future<void> logOut();
}
