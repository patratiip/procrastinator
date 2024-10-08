import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final IUserRepository authenticationRepository;
  late final StreamSubscription<MyUser> _userSubscription;
  late final StreamSubscription<MyUser> _userCollectionSubscription;

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
        // log('USER STREAM  ${user == state.user}');
        // log('USER STATE ${state.user}');
        // log('USER  ${user}');
      },
      cancelOnError: false,
    );

    on<AuthenticationUserChanged>((event, emit) {
      if (event.user != MyUser.empty) {
        emit(AuthenticationState.authenticated(event.user!));
      } else {
        emit(const AuthenticationState.unauthenticated());
      }
      // log('AUTH BLOC state: $state');
    });

    on<AuthenticationUserCollectionChanged>((event, emit) {
      emit(AuthenticationState.authenticated(event.user!));

      // log('AUTH BLOC Collection changed state: $state');
    });

    on<AuthenticationLogOut>((event, emit) {
      authenticationRepository.logOut();
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    _userCollectionSubscription.cancel();
    log('User subscription was cancelled');
    return super.close();
  }
}
