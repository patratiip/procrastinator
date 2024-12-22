import 'dart:async';
import 'dart:developer';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final IUserRepository authenticationRepository;
  late final StreamSubscription<MyUser> _userSubscription;

  AuthenticationBloc({required this.authenticationRepository})
      : super(
          authenticationRepository.currentUser.isNotEmpty
              ? AuthenticationState.authenticated(
                  authenticationRepository.currentUser)
              : const AuthenticationState.unauthenticated(),
        ) {
    on<AuthenticationEvent>(
      (event, emit) => switch (event) {
        final AuthenticationUserChanged e =>
          _authenticationUserChanged(e, emit),
        final AuthenticationLogOut e => _authenticationLogOut(e, emit)
      },
      transformer: sequential(),
    );

    // Subscription User
    _userSubscription = authenticationRepository.user.listen(
      (user) {
        add(AuthenticationUserChanged(user));
        log('USER  $user');
      },
      cancelOnError: false,
    );
  }

  Future<void> _authenticationUserChanged(AuthenticationUserChanged event,
      Emitter<AuthenticationState> emit) async {
    if (event.user != MyUser.empty) {
      emit(AuthenticationState.authenticated(event.user!));
    } else {
      emit(const AuthenticationState.unauthenticated());
    }
  }

  Future<void> _authenticationLogOut(
      AuthenticationLogOut event, Emitter<AuthenticationState> emit) async {
    authenticationRepository.logOut();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    log('User subscription was cancelled');
    return super.close();
  }
}
