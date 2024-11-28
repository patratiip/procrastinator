import 'models/models.dart';

abstract interface class IUserRepository {
  Stream<MyUser> get user;

  MyUser get currentUser;

  Future<MyUser> signUp(MyUser myUser, String password);

  Future<void> setUserData(MyUser user);

  Future<void> signIn(String email, String password);

  Future<void> onPasswordReseting({required String email});

  Future<void> logOut();
}
