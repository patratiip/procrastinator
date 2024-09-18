import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository authenticationRepository;
  late final StreamSubscription<MyUser?> _userSubscription;
  late final StreamSubscription<MyUser?> _userCollectionSubscription;

  AuthenticationBloc({required this.authenticationRepository})
      : super(
          authenticationRepository.currentUser.isNotEmpty
              ? AuthenticationState.authenticated(
                  authenticationRepository.currentUser)
              : const AuthenticationState.unauthenticated(),
        ) {
    //Subscription User
    _userSubscription = authenticationRepository.user.listen(
      (user) {
        add(AuthenticationUserChanged(user));
      },
      cancelOnError: false,
    );

    //Subscription User Collection
    _userCollectionSubscription =
        authenticationRepository.userCollection.listen(
      (user) {
        add(AuthenticationUserChanged(user));
        print('USER COLLECTION');
      },
      cancelOnError: false,
    );

    on<AuthenticationUserChanged>((event, emit) {
      if (event.user != MyUser.empty) {
        emit(AuthenticationState.authenticated(event.user!));
      } else {
        emit(const AuthenticationState.unauthenticated());
      }
      print('AUTH BLOC state: $state');
    });

    on<AuthenticationUserCollectionChanged>((event, emit) {
      emit(AuthenticationState.authenticated(event.user!));

      print('AUTH BLOC Collection changed state: $state');
    });

    on<AuthenticationLogOut>((event, emit) {
      authenticationRepository.logOut();
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    _userCollectionSubscription.cancel();
    print('User subscription was cancelled');
    return super.close();
  }
}
